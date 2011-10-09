/**
 *  fortunecookies.c -  create a fortune cookie file in /proc
 */

#include <linux/module.h>	/* Creating a module */
#include <linux/kernel.h>	/* Making KERNEL module */
#include <linux/proc_fs.h>	/* We need proc file system */
#include <asm/uaccess.h>	/* To use copy_from_user function */
#include <linux/random.h>	/* To use the random number generator of the kernel */

#define PROCFS_MAX_SIZE		300*1024	/* The size of the kernel buffer, default 300KB (for approximately 10000 lines of cookie) */
#define PROCFS_NAME 		"mycookie"	/* The name of the proc file, /proc/mycookie */
#define MAX_COOKIE_NUM		10000		/* The maximum number of the cookie lines, default 10000*/

/** It carries infomation about the /proc file*/
static struct proc_dir_entry *Proc_Mycookie;

/** The character buffer for kernel to store cookies */
static char procfs_buffer[PROCFS_MAX_SIZE];

/** The character pointer to keep track of the last char in the buffer*/
static char *procfs_buffer_index;

/** The size of the buffer */
static unsigned long procfs_buffer_size = 0;
/** The last size of the buffer */
static unsigned long procfs_last_size = 0;

/** Starting indice of the cookie sentences. */
static char *cookiestart[MAX_COOKIE_NUM];
static unsigned long last_cookie_index;

/** Size of the random bytes. Default is 2, so get_random_bytes return numbers less than 256^2 = 65536*/
static int random_byte_size = 2;

int get_random_number(int);

 /** It is called to read the /proc file */
int read_cookie(char *buffer, char **buffer_location, off_t offset, int buffer_length, int *eof, void *data)
{
	int ret,rndnum;
	char *firstloc,*secondloc;

	if (offset > 0)
	{
		/* we have finished to read, return 0 */
		ret  = 0;
	}
	else
	{
		/* Produce a random number smaller than last cookie number. */
		rndnum = get_random_number(last_cookie_index);
		/* Check if there is any cookie loaded */
		if (last_cookie_index == 0)
		{
			firstloc = "The input file was empty or you didn't suppy an input file yet.\n";
			/* Fill the buffer with this sentence. */
			memcpy(buffer, firstloc, ret);
			/* Return the buffer size. */
			ret = 64 * sizeof(char); /*64 = the character count of the sentence above */
		}
		else
		{
			/* Take the start and end adress of selected cookie. */
			firstloc = cookiestart[rndnum];
			secondloc = cookiestart[rndnum+1];
			/* Fill the buffer with this sentence */
			memcpy(buffer, firstloc, ret);
			/* Return the buffer size. */
			ret=(secondloc-firstloc)*sizeof(char);
		}
	}

	return ret;
}

/** This function is called with the /proc file is written */
int write_cookie(struct file *file, const char *buffer, unsigned long count, void *data)
{
	char *firstloc; /* Start location of the sentence */
	int testchar = '\n';

	/* get buffer size */
	procfs_buffer_size = count;

	/* If size of the last cookie file + the current buffer exceeds
	 * the maximum buffer size, only get a part of the last file */
	if ((procfs_last_size + procfs_buffer_size) > PROCFS_MAX_SIZE ) {
		procfs_buffer_size = PROCFS_MAX_SIZE - procfs_last_size;
		procfs_last_size = PROCFS_MAX_SIZE;
		printk(KERN_NOTICE "Buffer is full!\n");
	} else {
		/* Refresh the last size of the kernel buffer */
		procfs_last_size += procfs_buffer_size;
	}

	/* write data to the buffer */
	if ( copy_from_user(procfs_buffer_index, buffer, procfs_buffer_size) ) {
		/*If unsuccessful, return error */
		return -EFAULT;
	}

	/* The start of the first cookie is the start of the buffer */
	cookiestart[last_cookie_index++]=procfs_buffer_index;

	/* Record the start of all starting addresses of cookies */
	firstloc = procfs_buffer_index;
	while(1)
	{
		/* Seek the end of line */
		firstloc = memchr(firstloc, testchar, procfs_buffer_size);
		if (firstloc != NULL)
		{
			if (last_cookie_index==MAX_COOKIE_NUM)
				break;
			/* The end of the line is found, seek one character
			 * for the beginning of other cookie, then record it */
			firstloc+=sizeof(char);
			cookiestart[last_cookie_index++] = firstloc;
		} else { /* End of file */
			break;
		}
	}
	/* Remove the last enter from the last_cookie_index */
	last_cookie_index--;
	/* Refresh the pointer of the last byte in kernel buffer */
	procfs_buffer_index = procfs_buffer + procfs_last_size*sizeof(char);
	return procfs_buffer_size;
}

/** This function is called when the module is loaded */
int init_module()
{
	/* create the /proc file */
	/* Give the name of the proc file, the mode and its parent */
	Proc_Mycookie = create_proc_entry(PROCFS_NAME, 0644, NULL);

	/* Give an error message  and code if proc file cannot be initialized */
	if (Proc_Mycookie == NULL) {
		remove_proc_entry(PROCFS_NAME, &proc_root);
		printk(KERN_ALERT "Error: Could not initialize /proc/%s\n",PROCFS_NAME);
		return -ENOMEM; /* Not enough memory */
	}

	/* Set the fields of struct proc_dir_entry defined in
	  include/linux/proc_fs.h */
	Proc_Mycookie->read_proc  = read_cookie;
	Proc_Mycookie->write_proc = write_cookie;
	Proc_Mycookie->owner 	  = THIS_MODULE;
	Proc_Mycookie->mode 	  = S_IFREG | S_IRUGO;
	Proc_Mycookie->uid 	  = 0;
	Proc_Mycookie->gid 	  = 0;
	Proc_Mycookie->size 	  = 37;

	/* Set the last_cookie_index to 0*/
	last_cookie_index = 0;

	/* Set the buffer index to the beginning of buffer */
	procfs_buffer_index = procfs_buffer;

	if (MAX_COOKIE_NUM > 65536)
		random_byte_size = 3;

	printk(KERN_INFO "/proc/%s created\n", PROCFS_NAME);
	return 0;	/* everything is ok */
}

/** This function is called when the module is unloaded */
void cleanup_module()
{
	remove_proc_entry(PROCFS_NAME, &proc_root);
	printk(KERN_INFO "/proc/%s removed\n", PROCFS_NAME);
}

/** Returns a random number smaller than max. */
int get_random_number(int max)
{
	int tmp;
	get_random_bytes(&tmp,random_byte_size);
	if (max != 0)
		return tmp%max;
	return 0;
}

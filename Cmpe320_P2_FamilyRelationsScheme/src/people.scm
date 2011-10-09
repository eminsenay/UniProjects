; Emin Þenay - 2002103907 
; Cmpe 320 Project 2 - Scheme Project
; PEOPLE database is needed to be copied before executing this program.


;Function that is used by MOTHER and FATHER functions.
;Searches the given list and returns one of the parents of the element which is determined by the gndr field 
(define (parent element lst gndr)
  (cond
    ((null? lst) '())
    ((and (eq? (car(cdr(car lst))) gndr)
          (member element (cdr(car lst)))) (car (car lst)))
    (else (parent element (cdr lst) gndr))
    ))

;Function that checks if an element with a given gender exists in the list
(define (checkgender element gndr lst)
  (cond
    ((null? lst) #F)
    ((and (eq? (car (car lst)) element) 
          (eq? (car (cdr (car lst))) gndr)) #T)
    (else (checkgender element gndr (cdr lst)))
    ))

;Function that returns the males of the list. It checks the gender from the generallist
(define (takemales lst generallist)
  (cond
    ((null? lst) '())
    ((checkgender (car lst) 'male generallist) (cons (car lst) (takemales (cdr lst) generallist)))
    (else (takemales (cdr lst) generallist))
    ))

;Function that returns the females of the list. It checks the gender from the generallist
(define (takefemales lst generallist)
  (cond
    ((null? lst) '())
    ((checkgender (car lst) 'female generallist) (cons (car lst) (takefemales (cdr lst) generallist)))
    (else (takefemales (cdr lst) generallist))
    ))

;Function that is called by SON, DAUGHTER and children functions.
;It searches the generallist and returns sons, daughters, or all children of the element. This is determined by the gndr field. 
(define (child element lst generallist gndr)
  (cond
    ((null? lst) '())
    ((and (eq? (car (car lst)) element)
          (eq? gndr 'male))
     (takemales (cdr (cdr(car lst))) generallist) )
    ((and (eq? (car (car lst)) element)
          (eq? gndr 'female))
     (takefemales (cdr (cdr(car lst))) generallist) )
    ((and (eq? (car (car lst)) element)
          (eq? gndr 'all))
     (cdr (cdr (car lst))))
    (else (child element (cdr lst) generallist gndr))
    ))

;Driver function that lists all children of name
(define (children name)
  (child name PEOPLE PEOPLE 'all))

;Function that removes the duplicate elements from a given list
(define (removedup lst)
  (cond
    ((null? lst) '())
    ((member(car lst) (cdr lst)) (removedup (cdr lst)))
    (else (cons (car lst) (removedup (cdr lst))))
    ))

;Function that returns the union of two lists. Elements exist in the list only once 
(define (union list1 list2)
  (removedup(append list1 list2)))

;Function that returns the difference of list1 from list2. 
(define (setdifference list1 list2)
  (cond
    ((null? list1) '())
    ((member (car list1) list2) (setdifference (cdr list1) list2))
    (else (cons (car list1) (setdifference (cdr list1) list2)))
    ))

;Function that combines first and second in a list
(define (combine2 first second)
  (cond
    ((and (null? first) (null? second)) '())
    ((and (null? first) (not (null? second))) (list second))
    ((and (not (null? first)) (null? second)) (list first))
    (else (cons first (list second)))
    ))

;Function which is used by GRANDSON and NEPHEW function. Returns the union of sons of the elements in the list.
(define (listson name lst)
  (cond
    ((null? lst) '())
    (else (union (SON (car lst)) (listson name (cdr lst))))
    ))

;Function which is used by GRANDDAUGHTER and NIECE function. Returns the union of daughters of the elements in the list.
(define (listdaughter name lst)
  (cond
    ((null? lst) '())
    (else (union (DAUGHTER (car lst)) (listdaughter name (cdr lst))))
    ))

;Function which is used by COUSIN function. Returns the list of the cousins of the name
(define (cousin1 name auntuncle)
  (cond
    ((null? auntuncle) '())
    (else (union (children (car auntuncle)) (cousin1 name (cdr auntuncle))))
    ))

;Function which is used by DESC function. Returns the list of the descendants of the name
(define (descendants1 name childrenlist)
  (cond
    ((null? childrenlist) '())
    (else (union 
           (union (list (car childrenlist)) (descendants1 name (cdr childrenlist)))
           (DESC (car childrenlist))))
    ))

;Function which is used by GENDER function. Returns a list of people. The gender of all people is determined by type field
(define (gender1 type lst)
  (cond
    ((null? lst) '())
    ((eq? (car (cdr (car lst))) type) (cons (car (car lst)) (gender1 type (cdr lst))))
    (else (gender1 type (cdr lst)))
    ))

;Function which lists all of the relatives of the name
(define (relatives name) 
  (union (union (union (combine2 (MOTHER name) (FATHER name)) (union (children name) (SIBLING name))) (union (union (union (GRANDMOTHER name) (GRANDFATHER name)) (union (GRANDSON name) (GRANDDAUGHTER name))) (union (union (AUNT name) (UNCLE name)) (union (NIECE name) (NEPHEW name))))) (COUSIN name) )
  )

;main MOTHER function   
(define (MOTHER name)
  (parent name PEOPLE 'female)
  )

;main FATHER function
(define (FATHER name)
  (parent name PEOPLE 'male)
  )

;main SON function
(define (SON name)
  (child name PEOPLE PEOPLE 'male))

;main DAUGHTER function
(define (DAUGHTER name)
  (child name PEOPLE PEOPLE 'female))

;main SISTER function
(define (SISTER name)
  (setdifference (union (DAUGHTER (MOTHER name)) (DAUGHTER (FATHER name))) (cons name '())))  

;main BROTHER function
(define (BROTHER name)
  (setdifference (union (SON (MOTHER name)) (SON (FATHER name))) (cons name '())))

;main SIBLING function
(define (SIBLING name)
  (setdifference (union (children (MOTHER name)) (children (FATHER name))) (cons name '())))

;main GRANDMOTHER function
(define (GRANDMOTHER name)
  (combine2 (MOTHER (MOTHER name)) (MOTHER (FATHER name))))

;main GRANDFATHER function
(define (GRANDFATHER name)
  (combine2 (FATHER (MOTHER name)) (FATHER (FATHER name))))

;main GRANDSON function
(define (GRANDSON name)
  (listson name (children name)))

;main GRANDDAUGHTER function
(define (GRANDDAUGHTER name)
  (listdaughter name (children name)))

;main AUNT function
(define (AUNT name)
  (union (SISTER (MOTHER name)) (SISTER (FATHER name))))

;main UNCLE function
(define (UNCLE name)
  (union (BROTHER (MOTHER name)) (BROTHER (FATHER name))))

;main NIECE function
(define (NIECE name)
  (listdaughter name (SIBLING name)))

;main NEPHEW function
(define (NEPHEW name)
  (listson name (SIBLING name)))

;main COUSIN function
(define (COUSIN name)
  (cousin1 name (union (SIBLING (MOTHER name)) (SIBLING (FATHER name)))))

;function that lists descendants of the name
(define (DESC name)
  (descendants1 name (children name)))

;function that lists all people in the db with the given gender
(define (GENDER type)
  (gender1 type PEOPLE))

;function that checks if name2 is sibling of name1
(define (IS_SIBLING name1 name2)
  (cond
    ((member name2 (SIBLING name1)) #T)
    (else #F)
    ))

;function that drops out people from the list who are not relatives of person
(define (SAME_FAMILY person lst)
  (cond
    ((null? lst) '())
    ((member (car lst) (relatives person)) (SAME_FAMILY person (cdr lst)))
    (else (cons (car lst) (SAME_FAMILY person (cdr lst))))
    ))

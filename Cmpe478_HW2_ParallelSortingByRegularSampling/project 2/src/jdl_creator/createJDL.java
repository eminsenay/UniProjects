import java.io.File;
import java.io.FileWriter;

public class createJDL {
	
	/**
	 * Otomatik jdl hazirlayici. 
	 *
	 * */
	public static void main(String [] args)
	{
		int[] keysPerProcessor = {1000000,2000000,4000000,8000000,16000000};
		int[] step7Type = {1,2,3};
		int[] numberOfProcessors = {1,2,4,8,16,32,64};
		//String fileStart = args[0];
		//int[] fileNumbers = {1,4,8,16,32};
		
		//if(args[1].equals("1"))
		//{
		//	fileNumbers[0]=1;
		//	fileNumbers[1]=4;
		//	fileNumbers[2]=9;
		//	fileNumbers[3]=16;
		//	fileNumbers[4]=25;
		//}
		/*
		String jdlMPI = "Type=\"Job\";\nJobType=\"MPICH\";\nNodeNumber = \"" + nodeNumber + "\";\n" +
		"Executable = \"" + lu.S.4 + "\";\nStdOutput = \"" + deneme.out + "\";\nStdError = \"" + deneme.err + "\";\n" +
		"InputSandbox = {\"" + lu.S.4 + "\"};\nOutputSandbox = {\"" + deneme.out + "\",\"" + deneme.err + "\"};\nRetryCount = 3;";
		*/
		String inputFile = "cmpe478hw2_";
		String outputFile = "";
		String errorFile = "";
		String jdlFile = "";
		for (int i = 0; i < keysPerProcessor.length; i++)
		{
			for (int j = 0; j < step7Type.length; j++)
			{
				for (int k = 0; k < numberOfProcessors.length; k++)
				{
					StringBuffer jdlMPI1 = new StringBuffer("Type=\"Job\";\nJobType=\"MPICH\";\nNodeNumber = ");
					outputFile = keysPerProcessor[i] + "_" + step7Type[j] + "_" + numberOfProcessors[k] + ".out";
					errorFile = keysPerProcessor[i] + "_" + step7Type[j] + "_" + numberOfProcessors[k] + ".err";
					jdlFile = keysPerProcessor[i] + "_" + step7Type[j] + "_" + numberOfProcessors[k] + ".jdl";
					jdlMPI1.append(numberOfProcessors[k]);
					jdlMPI1.append(";\nExecutable = \"");
					inputFile += keysPerProcessor[i] + step7Type[j] + ".out";
					jdlMPI1.append(inputFile);
					//jdlMPI1.append("\";\nArguments = \"");
					//jdlMPI1.append(keysPerProcessor[i] + " " + step7Type[j] + " 0");
					jdlMPI1.append("\";\nStdOutput = \"");
					jdlMPI1.append(outputFile);
					jdlMPI1.append("\";\nStdError = \"");
					jdlMPI1.append(errorFile);
					jdlMPI1.append("\";\nInputSandbox = {\"");
					jdlMPI1.append(inputFile);
					jdlMPI1.append("\"};\nOutputSandbox = {\"");
					jdlMPI1.append(outputFile);
					jdlMPI1.append("\",\"");
					jdlMPI1.append(errorFile);
					jdlMPI1.append("\"};\nRetryCount = 3;");

					File outFile = new File(jdlFile);
					try {
						outFile.createNewFile();
						FileWriter fwrite = new FileWriter(outFile);
						fwrite.write(jdlMPI1.toString());
						fwrite.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
}

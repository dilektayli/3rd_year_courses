#include<stdio.h>
#include<stdlib.h>
int row_of_A = 20; 
int col_of_A = 20;
int row_of_B = 20;
int col_of_B = 20;

int main(){
	matrix_mul();
	return 0;
}

void matrix_mul(){ // acces the matrix text files and store them as matrices 
	FILE *fptr;

	// create matrixA, read text file and store it as matrixA
	int matrixA[row_of_A][col_of_A], matrixB[row_of_B][col_of_B], num;
	fptr = fopen("matrixA.txt", "r");
	for(int i=0; i<row_of_A; i++)
		for(int j=0; j<col_of_A; j++){
			fscanf(fptr, "%d", &num);
			matrixA[i][j] = num;
		}

	fptr = fopen("matrixB.txt", "r");
	// create matrixB, read text file and store it as matrixB
	for(int i=0 ; i<row_of_B; i++)
		for(int j=0; j<col_of_B; j++){
			fscanf(fptr, "%d", &num);
			matrixB[i][j] = num;
		}
	

	//multiplicate matrices (matrixA and matrixB)
	 if(col_of_A != row_of_B){
	 	printf("failed to multiplicate matrices because of dimension differences.\n");
	 }else{

		// create matrixC.txt to store the result matrix. 
	 	fptr = fopen("matrixC.txt", "w");
	 	for(int i=0; i<row_of_A; i++){
	 		for(int j=0; j<col_of_B; j++){
	 			long long int sum = 0;
	 			for(int k=0; k<col_of_A; k++){
	 				sum = sum + matrixA[i][k] * matrixB[k][j];
	 			}
	 			fprintf(fptr, "%lld ", sum);
	 		}
	 		fprintf(fptr, "\n");
	 	}
	 	printf("Control matrixC.txt for result matrix.\n");
	 }	
}
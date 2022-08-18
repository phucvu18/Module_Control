#include "stdafx.h"

//���������� � ������������� ���������� ����������
int N=0,M=0;
double TIME=0.0,DT=0.0;

void MODELING(double K[])
{
	//���� ������
	FILE *fOUT;
	//�������� � �������� ��� ������
	fOUT=fopen(".\\RESULT\\OUT.ris","w");	
	
	// ������������� ���������� �������������
	N=4;	//����� ���������� ���������	
	M=1;	//����� �������� ����������	
	DT=0.001;	//��� ��������������
	
	//����� �������������
	double TMODEL=1.E+1;

	// ���������� ������� ��������� X(N)
	double* X = new double [N]; 
	// ���������� ������� ��������� X(N)
	double* DX = new double [N]; 
	//���������� ������� ����������
	double* U = new double [M]; 
	double* U0 = new double [M]; 

	for (int i=0;i<N;i++)
	{
		X[i]=0.0;
		DX[i]=0.0;
	}
	//������������� ���������� ��������� �������
	X[0]=0.0;
	X[1]=1.0;  // ������
	//X[1]=1.0*3.14/180;  //����
	X[2]=0.0;
	X[3]=0.0;
	U[0]=0.0;
	U0[0]=0.0;
	//��������� �������
	kP=K[1];
	kI=K[2];
	kD=K[3];


	//������ ������ �����������: fprintf(fOUT,"U1 U2 ...Um X0 X1 X2 ... Xn");
	fprintf(fOUT,"U XI X XD XDF");	
	
	// ���� �������������
	do
	{	
		//������ �����������
		fprintf(fOUT,"\n%f ",TIME);		//�����
		for (int i=0;i<M;i++)
			fprintf(fOUT,"%f ",U[i]);	//������ ����������	
		for (int i=0;i<N;i++)
			fprintf(fOUT,"%f ",X[i]);	//������ ���������

		//�������������� (1 ���)
		RKS(N,DT,TIME,DX,X,U,FX);
		//������� ����������
		CONTROL(X,U,U0);
	
	}while (TIME<TMODEL);
}
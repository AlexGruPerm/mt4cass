#property version "1.0"
#import "kernel32.dll"   
    
int GetModuleHandleA(string lpString);
int FreeLibrary(int hModule);  
int LoadLibraryA(string lpString);
 
#import "mt4cass.dll"  
void savetick(char&[],char&[], double pBid, double pAsk, int currdt);
#import

char hosts[10240];
char cSymbol[10240];

int OnInit(){
   StringToCharArray("127.0.0.1", hosts);
   Print("OnInit Symbol = "+Symbol());
   StringToCharArray(Symbol(), cSymbol);
   return(INIT_SUCCEEDED);
}

void OnTick(){
 savetick(hosts,cSymbol,Bid,Ask,TimeCurrent());
}


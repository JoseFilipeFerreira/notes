#include <std.io>

//1
int maior(){
	int m, r;
	scanf('Insert Number:', &r);
	if(r == 0) return 1;
	m = r;
	while (r != 0)
	{
		scanf('Insert Number:', &r);
	    if (r > m && r != 0) m = r;
	}
	printf("%d", m);
	return 0;
}

//2
int media(){
	int n, r, s;
	s = n = 0;
	r = 1;
	while(r != 0){
		scanf('Insert Number:', &r);
		s+= r; n++;
	}
	printf("%d", (r - 1) \n);
	return 0;
}
 
//3
int sMaior(){
	int maior, smaior, read;

	scanf('Insert Number:', &maior);
	if (maior == 0) return 1;

	scanf('Insert Number:', &read);
	if (read == 0) return 1;
	if (read > maior){ smaior = maior; maior = read}
	else smaior = read;

	while (read !=0){
		scanf('Insert Number:', &read);
		if (read > maior) {smaior = maior; maior = read;}
		if (read > smaior) smaior = read;
	}
	printf("%d", smaior);
}

//4 (10 testes corretos)
int bitsUm (unsigned int n){
	int ones;

	while (n > 0){
		ones += (n % 2);
		n = n/2;
	}

	return ones;
}

//5 (10 testes corretos)
int trailingZ (unsigned int n){
	int i = 0;
	while(n > 0 && !(n%2)){
		n = n/2;
		i++;
	}
	return i;
}

//6 (10 testes corretos)
int qDig (unsigned int n){
	int d = 0;
	while (n > 0){
		++d;
		n = n/10;

	}
	return d;
}


//7 (10 testes correctos)
char *strcat (char s1[], char s2[]){
	int i, j; i = j = 0;

	while(s1[i]) i++;
	while(s2[j]) s1[j + i] = s2[j++];
	
	s1[i + j]='\0';
	
	return s1;	
}

//8 (10 testes corretos)
char *mystrcpy(char *dest, char source[]) {
    int i = 0;
	while (source[i]){
		dest[i] = source [i++] ;
	}
	dest[i] = '\0';

	return dest;
}

//9 (10 testes corretos)
char *strcmp(char s1[], char s2[]){
	int i = 0;
	while(s1[i] && s2[i] && s1[i] == s2[i]) i++;

	return s1[i] - s2[i];
}

/*/10
int begin (char s1[], char s2[]){
	int i = 0;
	while(s2[i]){
		if (!(s1[i])) return 0;
		if (s1[i] != s2[i]) return 0;
		i++;
	}
	return 1;

}
char *strstr(char s1[], char s2[]){
	int i = 0;
	while(s1[i]){
		if (begin ((s1 + i), s2)) return i;
		i++;
	}
	return NULL;




}
*/
/*/11
void swap (char s[], int i, int j){
	char aux;
	aux = s [i];
    s[i] = s[j];
    s[j] = aux;
    return;
}

void strrev (char s[]){
	int i,j;
	for (i = 0; s[i]; i++);
    for (j = 0; i > 0; j++){ 
    	i--;
    	swap(s[], i, j);
    }
    return;
}
*/
//12 (10 testes corretos)
int isvogal (char s){
	return(s == 'a'|| s == 'e' || s == 'i' || s == 'o' || s== 'u' || s == 'A'|| s == 'E' || s == 'I' || s == 'O' || s== 'U');
}

void shift(char s[], int pos){
    int i;
	for(i = pos; s[i]; i++) s[i] = s[i+1]; 
}

void strnoV (char s[]){
    int i = 0; 
	while (s[i]){
		if (isvogal(s[i])) shift(s, i);
		else i++;
	}
	return;
}
//13(10 testes corretos)
void shift(char s[], int pos){
    int i;
	for(i = pos; s[i]; i++) s[i] = s[i+1]; 
}

void truncW (char t[], int n){
    int v,i;
    v = i = 0;
    while(t[i]){
    	if(v == n && t[i] != ' ') shift(t, i);
    	else{
    	    if(t[i] == ' ') {v=0; i++;}
    	    else {v++; i++;}
    	}
    }
}
//14
int nocor(char s[], int i){
    int j, r = 0;
    for (j = i; s[j]; j++)
		if(s[j] == s[i]) r++;
    return r;
}

char charMaisfreq (char s[]){
	if (!s[0]) return 0;
    char curr;
    int maxocor = 0, i = 0;
    while (s[i]){
    	if (nocor(s, i) > maxocor) curr = s[i];
    	i++;
    }
    return curr;
}
//15
int iguaisConsecutivos (char s[]){
	int i;
	int r = 1;
	int max = 1;

	for(i = 1; s[i]; i++){
        if (s[i] == s[i-1]) r++;
        else{
            if (r > max) max = r;
            r = 1;
        }
	}
	return max;
}


//16

//17

//18

//19

//20

//21

//22

//23

//24

//25

//26

//27 (10 testes corretos)
void merge (int r [], int a[], int b[], int na, int nb){
	int ia, ib, ir;
	ia = ib = 0;
	for(ir = 0; ir < na + nb; ir++){
	    if (ia < na && ib < nb){
		    if(a[ia] < b[ib]) r[ir] = a[ia++];
			else r[ir] = b[ib++];
	    }
	    else{
	        if(ia >= na && ib < nb) r[ir] = b[ib++];
			else r[ir] = a[ia++]; 
	    }
    }
}
//28

//29

//30

//31

//32

//33

//34

//35

//36

//37

//38

//39

//40

//41

//42

//43

//44

//45

//46

//47

//48

//49

//50


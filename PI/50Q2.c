#import <stdrio.h>

typedef struct lligada{
	int valor;
	struct lligada * prox;

}*LInt;

//--------------------------------------------------------------------------------- 1

int length(LInt l) //10 testes corretos
{
	int r = 0;
	while (l){
		l = l->prox;
		r++;
	}
	return r;
}

//--------------------------------------------------------------------------------- 2


void freeL(LInt l)
{
	LInt freer;
	int r = 0;
	while (l){
		freer = l;
		l = l->prox;
		free(freer);
	}
}

//--------------------------------------------------------------------------------- 3

void imprimeL(LInt l)
{
	while (l){
		printf("%d\n", l->);
	}
}

//--------------------------------------------------------------------------------- 4

LInt reverseL (LInt l){ //10 testes corretos
	LInt prev, next;
	prev = NULL;
	
	if(l == NULL) return NULL;

	while(l->prox)
	{
		next = l -> prox;
		l -> prox = prev;
		prev = l;
		l = next;
	}
	l -> prox = prev;
	return l;
}

//--------------------------------------------------------------------------------- 5

void insertOrd(LInt *l, int x)
{
	LInt pl = *l;
	LInt new = malloc(sizeof(struct lligada));
	new -> valor = x;
	new -> prox = NULL;

	if(pl == NULL)
		*l = new;
	else
	{
		while(pl && pl->valor < x)
		{
			pl = pl->prox;
		}
		new -> prox = pl;
		pl -> prox = new;
	}
}

//--------------------------------------------------------------------------------- 7

void merge(LInt *r, LInt a, LInt b)
{
	LInt pr;
	
	if(!a && !b) return;

	if (a && b && a -> valor > b -> valor)
	{
    	*r = b;
    	b = b -> prox;
    }
    else
    {
        if (a && b && a -> valor < b -> valor)
        {
        	*r = a;
        	a = a -> prox;
        }
        else
        {
            if (a && !b)
            {
            	*r = a;
            	a = a -> prox;
            }
            else
            {
                if (b && !a)
                {
                	*r = b;
                	b = b -> prox;
                }
            }
        }
    }

    pr = *r;

	while(a && b)
	{
	    if (a -> valor > b -> valor)
	        {
                pr -> prox = b;
                b = b -> prox;
                pr = pr -> prox;
	        }
	    else
	    {
		    pr -> prox = a;
		    a = a -> prox;
		    pr = pr -> prox;
	    }
	}

	if(a && !b)
	{
		while(a)
		{
			pr -> prox = a;
			a = a -> prox;
		}

	}
	else
	{
	    if(b && !a)
	    {
	        while(b)
	        {
	        	pr -> prox = b;
	        	b = b -> prox;
	        }
    
	    }
	}
}

//--------------------------------------------------------------------------------- 9

int lenLInt(LInt l)
{
	int s = 0;
	while(l)
	{
		l = l->prox;
		s++;
	}

	return s;
}


LInt parteAmeio (LInt *l)
{
	LInt r, aux;
	int s = lenLInt(*l);
	s = s/2;

	r = *l;

	while(s -1 > 0)
	{
		*l = (*l) -> prox;
		s--; 
	}
	aux = *l;
	*l = (*l) -> prox;
	aux -> prox = NULL;
	
	return r;
}

//---------------------------------------------------------------------------------

int removeOneOrd(LInt* l, int x)
{
	int r = 1;
	int flag = 0;
	LInt pl = *l;
	LInt ant = NULL;

	while(pl && pl -> valor < x)
	{
	    ant = pl;
        pl = pl -> prox;
        flag = 1;
	}
	if(pl && pl -> valor == x)
	{
		if(flag)
		{
		    ant -> prox = pl -> prox;
		    r = 0;
		}
		else
		{
		    *l = pl -> prox;
	        r = 0;
		}
	}

	return r;
}


//--------------------------------------------------------------------------------- 11
int removeDups(LInt * a)
{
	int r = 0, x;
	LInt pa = *a, la, ant;
	while(pa)
	{
	    ant = pa;
	    la = pa -> prox;
	    x = pa -> valor;
		while(la)
	    {
		    if(la -> valor == x)
		    {
			    r++;
		        ant -> prox = la -> prox;
		    }
		    else
		    {
			    ant = la;
			    la = la -> prox;
		    }


	    }
	pa = pa -> prox;
	}

	return r;

}


//--------------------------------------------------------------------------------- 28

#define MAX(x,y) ((x>y)?x:y)

int altura(ABin a) //10 testes corretos
{
    int r = -1;
	if(a != NULL)
	{
		r = 1 + MAX(altura(a -> esq), altura(a -> dir));
	}
	
	return r;
}

//--------------------------------------------------------------------------------- 29

ABin cloneAB(ABin a) //10 testes corretos
{
	if(!a) return NULL;
	ABin new = malloc(sizeof(struct nodo));
	new->valor = a -> valor;
	new -> esq = cloneAB(a->esq); 
	new -> dir = cloneAB(a->dir);
	return new;
}


//--------------------------------------------------------------------------------- 30
void mirror(ABin *a) //10 testes corretos
{
	ABin aux;
	if (*a)
	{
		
		mirror(&(*a)->dir);
		mirror(&(*a)->esq);
		aux = (*a)-> esq;
		(*a) -> esq = (*a) -> dir;
		(*a) -> dir = aux;

	}
}

//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------37
int iguaisAB(ABin a, ABin b) // 10 testes corretos
{
	if(!a && !b)
		return 1;
	if(a && b)
	{
		return (a->valor == b->valor && iguaisAB(a->esq,b->esq) && iguaisAB(a->dir, b->dir));
	}

	return 0;
}


//---------------------------------------------------------------------------------

//--------------------------------------------------------------------------------- 42

int contaFolhas(ABin a) // 10 testes corretos
{
	if (a == NULL) return 0;

	if(a && a-> esq == NULL && a -> dir == NULL) return 1;

	if(a) return (contaFolhas(a->esq) + contaFolhas (a->dir));
	

}

//---------------------------------------------------------------------------------

//--------------------------------------------------------------------------------- 47

int maiorAB(ABin a) //10 testes corretos
{
	while(a && a-> dir)
		a = a -> dir;

	return a-> valor;
}

//--------------------------------------------------------------------------------- 48

void removeMaiorA(ABin * a)
{
	ABin pa = *a;
	ABin aux, bNew;

	if(!pa) return;
	if (!pa->dir)
	{
		*a = pa -> esq;
		return;
	}
	
	while(pa && pa-> dir)
    {
		aux = pa;
		pa = pa->dir;
	}

	bNew = biger





}

//--------------------------------------------------------------------------------- 49
int quantosMaiores(ABin a, int x)
{
    if (!a) return 0;
	if(a->valor > x)
		return 1 + quantosMaiores(a->esq, x) + quantosMaiores(a->dir, x);
	else
		return quantosMaiores(a->dir, x);
}

//--------------------------------------------------------------------------------- 50

//--------------------------------------------------------------------------------- 51

int deProcura (ABin a)
{
    if(!a) return 1;

    if(a && a->esq == NULL && a->dir == NULL) return 1;

    if(a && a->esq && a->dir) return (allSmaller(a->esq, a->valor) && allBigger(a->dir, a->valor) && deProcura(a->esq) &&  deProcura(a->dir) );

    if(a && a->esq && (!a->dir)) return (allSmaller(a->esq, a->valor)&& deProcura(a->esq)  );

    if(a && a->dir && (!a->esq)) return (allBigger(a->dir, a->valor)&& deProcura(a->dir) );

    return 0;
}

int allSmaller(ABin a, int x)
{
	if (!a) return 1;
    
    if(a->valor < x)
    {
    	return (allSmaller(a->esq, x) && allSmaller(a->dir, x));
    }
    return 0;
}

int allBigger(ABin a, int x)
{
	if (!a) return 1;
    
    if(a->valor > x)
    {
    	return (allSmaller(a->esq, x) && allSmaller(a->dir, x));
    }
    return 0;
}
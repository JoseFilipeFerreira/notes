// prime filter object
class PrimeServer {
    int* myPrimes; // buffer to hold computed primes
    int nPrimes;   // number of primes computed

    double timei;
    int totalPrimes;

  public:
    // check if is a prime number
    int isPrime(int num, int* primes, int cont) {
        int j = 0;
        while (j < cont && ((num % (primes[j])) != 0)) j++;
        return (j == cont);
    }

    // compute primes upto max
    int lowPrimes(int max, int* primes) {
        int cur = 1;
        primes[0] = 3;

        for (int i = 5; i < max; i += 2)
            if (isPrime(i, primes, cur)) primes[cur++] = i;

        return (cur);
    }

    // init the range of primes for this filter
    void initFilter(int myMinP, int myMaxP, int SMaxP) {
        nPrimes = 0;

        int pr[SMaxP];
        int nl = lowPrimes(SMaxP, pr); // compute primes upto SMaxP

        myPrimes = new int[nl];
        for (int i = 0; i < nl; i++) // save my range of primes
            if (pr[i] >= myMinP && pr[i] <= myMaxP) myPrimes[nPrimes++] = pr[i];
        std::cout << nPrimes << " Primes " << myMinP << " ... " << myMaxP << "\n";

        totalPrimes = 0;
        timei = MPI_Wtime(); // start counting time
    }

    // remove nonprimes from "num" array
    void mprocess(int num[], int tam) {

        for (int i = 0; i < tam; i++) {
            if (num[i] > 2) {
                if (isPrime(num[i], myPrimes, nPrimes))
                    totalPrimes++;
                else
                    num[i] = 0; // remove from list
            }
        }
    }

    // end of processing
    void end() {
        double timef = MPI_Wtime();
        std::cout << "Demorou " << (timef - timei) / 1000 << "s " << totalPrimes << " primos\n";
    }
};

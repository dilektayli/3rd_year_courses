#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <semaphore.h>


// I did not include n(the number of chairs) since it was not included in the input


// max number of threads
#define MAX_CUSTOMERS 27

// define the semaphores

// waiting_room(chair) limits the # of customers allowed to enter the waiting room at one time. 
sem_t waiting_room;

// make barber chair mutually exclusive
 sem_t barber_chair;

 // allow the barber to sleep when there is no customer
 sem_t barber_pillow;

 // allow the barber to finish cutting the hair of customer
 sem_t cutting_hair;

 // flag to stop the barber thread when there is no hair to be cutted.
int all_done;
int num_customer;
int max_arrival_time;
int max_haircut_duration;
int max_haircut_repetition;
int cut_time;

int main(int argc, char *argv[]){

    num_customer = atoi(argv[1]);
    max_arrival_time = atoi(argv[2]);
    max_haircut_duration = atoi(argv[3]);
    max_haircut_repetition = atoi(argv[4]);
    cut_time = max_haircut_duration*max_haircut_repetition; // time of total haircut for only one customer.



    void* customer(void* num_customer,void* max_arrival_time);
    void *barber(void *,void* cut_time);

    

    pthread_t btid;
    pthread_t tid[MAX_CUSTOMERS];
    long RandSeed;
    int i;
    int Number[MAX_CUSTOMERS];

// before adding makefile, I used these lines to get inputs from the user.
    /*
    printf("Enter the number of customers: "); 
    scanf("%d",&num_customers);
    printf("Enter the number of chairs: ");
    scanf("%d",&num_chairs);

    printf("Enter the duration for haircut: "); 
    scanf("%d",&haircut_duration);
    printf("Enter the number of haircut repetition: ");
    scanf("%d",&haircut_repetition);
    */

    // make sure the threads is less than the numbers of customers
    if(num_customer>MAX_CUSTOMERS){
        printf("The maximum number of customers is %d. \n",MAX_CUSTOMERS);
        exit(-1);
    }

    // initialize the numbers array
    for(i = 0; i<MAX_CUSTOMERS; i++)
        Number[i] = i;
    

    int num_chairs = 2; // assign a random value to chairs since it was not included in the question.

    // initialize the semaphores to their inital values
    sem_init(&waiting_room,0,num_chairs);
    sem_init(&barber_chair,0,1);
    sem_init(&barber_pillow,0,0);
    sem_init(&cutting_hair,0,0);

    // create barber thread
    pthread_create(&btid,NULL,barber,NULL);

    //create the customers' threads
    for(i = 0; i<num_customer; i++){
        pthread_create(&tid[i],NULL,customer,(void *)&Number[i]);
        sleep(1);
    }

    //join each of the thread to wait for them to finish
    for(i=0; i<num_customer; i++){
        pthread_join(tid[i],NULL);
        sleep(1);
    }

    // when all of the customers are finished, kill the barber thread.
    all_done = 1;
    sem_post(&barber_pillow);
    pthread_join(btid,NULL);

}

void *customer(void *number,void *time_arrive){
    int num = *(int *) number;
    int arriveTime = *(int *) time_arrive;


    // leave for the shop and take some amount of time to arrive which is given by the user. 
    printf("Customer %d coming to the barber shop.\n",num);
    arrive_time(arriveTime); 
    printf("Customer %d arrived at the barber shop.\n",num);

    // wait for chair to open up in the waiting room
    sem_wait(&waiting_room);
    printf("Customer %d is entering to the waiting room.\n",num);

    // wait for the barber chair to be free
    sem_wait(&barber_chair);

    // barber chair is empty now, so leave the waiting room
    sem_post(&waiting_room);

    // wake up the barber
    printf("Customer %d is waking the barber.\n",num);
    sem_post(&barber_pillow);

    // wait for the barber to finish the cutting hair task
    sem_wait(&cutting_hair);

    // leave the barber chair
    sem_post(&barber_chair);
    printf("Customer %d is leaving the barber shop. \n",num);
}

void *barber(void *junk,void *time_cut){
    int cut_time = *(int *) time_cut;

    // while there are customer's hair to be cutted...

    while(!all_done){

        // Sleep until someone arrives and wakes you..
        printf("The barber is sleeping\n");
        sem_wait(&barber_pillow);

        if(!all_done){
            // take random amount of time to the customer's hair
            printf("The barber is cutting hair.\n");
            haircut_time(cut_time);
            printf("The barber is finished cutting hair.\n");
            sem_post(&cutting_hair); // release the customer when done cutting
        }else{
            printf("The barber is done for the day.\n");
            }
    } 
}

void arrive_time(int secs){
    int length;
    length = (int) ((1*secs)+1);
    sleep(length);
}

void haircut_time(int time){
    sleep(time);
}
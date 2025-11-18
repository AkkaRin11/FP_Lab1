package org.example;


import static java.lang.Math.pow;

public class Main {
    public static void main(String[] args) {
        System.out.println(multiplesOf3Or5());
        System.out.println(digitFifthPowers());
    }

    public static long multiplesOf3Or5() {
        long sum = 0;

        for (long i = 1; i < 1000; i++) {
            if (i % 3 == 0 || i % 5 == 0) {
                sum += i;
            }
        }

        return sum;
    }

    public static long digitFifthPowers() {
        long sum = 0;

        for (long i = 2; i < 200000; i++) {
            long tmp = i;
            long tmpSum = 0;

            while (tmp != 0) {
                tmpSum += (long) pow(tmp % 10, 5);
                tmp /= 10;
            }

            if (tmpSum == i){
                sum += i;
            }
        }

        return sum;
    }

}
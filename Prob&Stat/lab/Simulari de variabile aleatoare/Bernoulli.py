# -*- coding: utf-8 -*-
"""Bernoulli.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1QUImLHZy87y0MLlLm28rH1chSzmJvBQd
"""

import numpy as np
import matplotlib.pyplot as plt

def Bernoulli(N, p):
    P = []
    
    Bernoulli = np.random.uniform(0, 1, size = N)
  
    for i in range(N):
       Bernoulli[i] = 1 * (Bernoulli[i] < p)

    P_B = np.cumsum(Bernoulli)
    P = np.divide(P_B, range(1, N+1))
    
    plt.plot(P)
    plt.show()

def main():
    Bernoulli(10000, 0.3)
if __name__ == "__main__":
    main()
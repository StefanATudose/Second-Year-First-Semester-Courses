# -*- coding: utf-8 -*-
"""TLC.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1p6nYMcVX8LbN-Sr0mgwpOsxGJ8-u25Ka
"""

import numpy as np
import matplotlib.pyplot as plt

def Exponential(l, N):

    uniform_array = []
    for i in range(N):
        uniform_array.append(np.random.uniform(0, 1))
    
    logs = np.log(uniform_array)
    exp_simulated = [log * (-1) for log in logs] 


    return exp_simulated



def TLC(n, N, p):

  R_V = [0] * N
  S = [0] * N
  S_bar = [0] * N
  l = 1
  for i in range(n):
    R_V = Exponential(1, N)
    for j in range(N):
      S[j] += R_V[j]
      if i > 0:
        S_bar[j] = S[j]/i
    plt.hist(S_bar, 100, density = True, 
              histtype ='bar',
              color = 'blue',
              label = 'hist')
    plt.pause(0.5)

def main():
    
    TLC(20, 10000, 0.3)
if __name__ == "__main__":
    main()
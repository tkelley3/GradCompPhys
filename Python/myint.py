# -*- coding: utf-8 -*-
"""
Created on Wed May 18 16:13:51 2016

@author: Tom
"""
from numpy import sqrt,ones,copy,cos,sin,tan,pi,linspace,array,exp,arange
import matplotlib.pyplot as pyl




def trapezoidrule(f,a,b,N=10):
    h = (b-a)/N
    s = 0.5*f(a) + 0.5*f(b)
    for k in range(1,N):
        s += f(a+k*h)
    return h*s

def trapezoiderr(f,a,b,N=10):
    I1 = trapezoidrule(f,a,b,int(N/2))
    I2 = trapezoidrule(f,a,b,N)
    err2 = (I2-I1)/3
    return abs(err2)
    
def simpsonrule(f,a,b,N=10):
    h = (b-a)/N
    s = f(a)/3+f(b)/3
    for k in range(1,N):
        if k%2:
            s += (4/3)*f(a+k*h)
        else:
            s += (2/3)*f(a+k*h)
    return h*s
    
def simpsonerr(f,a,b,N=10):
    I1 = simpsonrule(f,a,b,int(N/2))
    I2 = simpsonrule(f,a,b,N)
    err2 = (I2-I1)/15
    return abs(err2)

def cubicrule(f,a,b,N=10):
    h = (b-a)/N
    s = (3/8)*f(a)+(3/8)*f(b)
    for k in range(1,N):
        if k%3:
            s += (9/8)*f(a+k*h)
        else:
            s += (3/4)*f(a+k*h)
    return h*s
    
def quarticrule(f,a,b,N=10):
    h = (b-a)/N
    s = (14/45)*f(a)+(14/45)*f(b)
    for k in range(1,N):
        if k%4==0:
            s += (28/45)*f(a+k*h)
        elif k%4==2:
            s += (8/15)*f(a+k*h)
        else:
            s += (64/45)*f(a+k*h)
    return h*s

def rombergrule(f,a,b,N=10,accuracy=10**(-9)):
    from numpy import zeros
    R = zeros([N,N])
    err = zeros(N)
    R[0,0] = trapezoidrule(f,a,b,N)
    err[0] = trapezoiderr(f,a,b,N)
    i=0
    while abs(err[i])>accuracy:
        i+=1
        N = 2*N
        R[i,0]=trapezoidrule(f, a,b,N)
        
        for k in range(1,i+1):
            R[i,k]=R[i,k-1]+1/(4**(k+1)-1)*(R[i,k-1]-R[i-1,k-1])
        err[i] = 1/(4**(i+1)-1)*(R[i,i-1]-R[i-1,i-1])
    return R[i,i]



        

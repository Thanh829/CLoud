# -*- coding: utf-8 -*-
"""
Created on Thu Jun 18 05:59:11 2020

@author: Thanh
"""
from firebase import firebase
import pandas as pd
import csv
from scipy import stats
import matplotlib.pyplot as plt
firebase = firebase.FirebaseApplication("https://myproject-41598.firebaseio.com/", None)
def LayTatCaDuLieu():

    
    result = firebase.get('/DHT11/Data','')
    #print (result)
    
    df = pd.DataFrame(result)
    
    transpose = df.transpose()
    
    #print(transpose)
    
    transpose.dropna(how='all', inplace=True)
   
    return transpose

def LayDuLieuCuoi():
    df = LayTatCaDuLieu()
   
    df['Temperature']=[float(i) for i in df['Temperature']]
    df['Temperature'].fillna(df['Temperature'].mean(),inplace=True)
    last= df['Temperature'][-1:]
    return last[0]
def LayTG():
    df = LayTatCaDuLieu()
    #dt_list=[float(i) for i in dt_list]
    last= df['Humidity'][-1:]
    return last[0]    

def LamSachDuLieu():

    df = LayTatCaDuLieu()
   
    dt_list=df['Temperature'].tolist()
    dt_list_Humid=df['Humidity'].tolist()
    dt_list=[float(i) for i in dt_list]
    
    
   
    df_model=pd.DataFrame()
    df_model['x'] =dt_list[:-1]
    df_model['y']=dt_list[1:]
    df_model['x'].fillna(df_model['x'].mean(),inplace=True)
    df_model['y'].fillna(df_model['y'].mean(),inplace=True)
    last=dt_list[-1:]
    last_Humid=dt_list_Humid[-1:]
    
    """
    df['Temperature']=[float(i) for i in df['Temperature']]
    df['Temperature'].fillna(df['Temperature'].mean(),inplace=True)
    df_model=pd.DataFrame()
    df_model['x'] =df['Temperature'][:-1]
    df_model['y']=df['Temperature'][1:]
    """
    size_train=int(len(df_model)*0.8)
    df_train=df_model[:size_train] #=[0:size_train]
    df_test=df_model[size_train:]  #=[size_train:end]
    
   
    a,b,c,d,e=stats.linregress(df_train['x'],df_train['y'])
    
    plt.scatter(df_test['x'], df_test['y'])
    plt.plot(df_test['x'], f(df_test['x']))
    plt.show()
    
    return a,b,last[0],float(last_Humid[0])
LamSachDuLieu()
def f(x):                       #tính theo tham số truyền vào
    
    a,b,y,z = LamSachDuLieu()
    return a*x + b
def f2():                         # tính theo nhiệt độ hiện tại
    a,b,current, current_humid = LamSachDuLieu()
    return a*current+ b,current, current_humid

"""
plt.scatter(df_test['x'], df_test['y'])
plt.plot(df_test['x'], f(df_test['x']))
plt.show()

df_model.plot.scatter(x='x',y='y',c='DarkBlue')
#print (df_model)
"""

# -*- coding: utf-8 -*-
"""
Created on Sun Jun 28 10:15:05 2020

@author: Thanh
"""


# -*- coding: utf-8 -*-
"""
Created on Sun Jun 28 09:55:17 2020

@author: Thanh
"""


from firebase import firebase 
import numpy as np
import pandas as pd
import scipy.stats as stats
import matplotlib.pyplot as plt
import sklearn
import statsmodels.api as sm
from scipy import stats
 
import seaborn as sns
sns.set_style("whitegrid")
sns.set_context("poster")
 
# special matplotlib argument for improved plots
from matplotlib import rcParams
from sklearn.datasets import load_boston
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression


firebase = firebase.FirebaseApplication("https://myproject-41598.firebaseio.com/", None)

def LayDuLieu():
    result = firebase.get('/DHT11/Data','')
       
     
    bos = pd.DataFrame(result)
    
   
    bos=bos.transpose() 
   
    
    df_Temp=bos['Temperature'].tolist()
    df_Humid=bos['Humidity'].tolist()
    df_Temp=[float(i) for i in df_Temp]
  
    df_Humid=[float(i) for i in df_Humid]
    
    df_model=pd.DataFrame()
    df_model['FutureTemp']=df_Temp[1:]
    df_model['Temp'] = df_Temp[:-1]
    df_model['Humid']=df_Humid[:-1]
    df_model.dropna(how='all', inplace=True)
    
    df_model['Temp'].fillna(df_model['Temp'].mean(),inplace=True)
    df_model['FutureTemp'].fillna(df_model['FutureTemp'].mean(),inplace=True)
    df_model['Humid'].fillna(df_model['Humid'].mean(),inplace=True)
    
    X = df_model.drop('FutureTemp',axis=1)
    Y = df_model['FutureTemp']
    
    
    
    
    
    
    
     
    lm = LinearRegression()
    lm.fit(X, Y)
    
    
    a,b=lm.coef_
    inct=lm.intercept_
    return a,b,inct

def f(temp,humid):
    a,b,inct=LayDuLieu()
    return  inct + a*temp +b*humid





 
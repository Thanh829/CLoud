# -*- coding: utf-8 -*-
"""
Created on Sat Jun 27 16:59:14 2020

@author: Thanh
"""


from flask import Flask, jsonify
import ThuVienChoFase3_ThoiGianThuc as ThuVienFase3
import HoiQuyDaBienTemp as HoiQuyDaBien
app = Flask(__name__)
app.config["DEBUG"]=True

@app.route('/',methods=['GET'])
def home():
    return "Hello"

@app.route('/iot',methods=['GET'])
def getNextFromCurrent():
    
    next_temp,current_temp, current_humid=ThuVienFase3.f2()
  
    return jsonify({'current': current_temp, 'current_humid': current_humid,'next':next_temp})


@app.route('/iot/<float:temp>',methods=['GET'])
def getNext(temp):
    next_temp=  ThuVienFase3.f(temp)
    return jsonify({'next': next_temp})


@app.route('/iot/<float:temp>/<float:humid>',methods=['GET'])
def getNext2(temp,humid):
    next_temp= HoiQuyDaBien.f(temp,humid)
    return jsonify({'next': next_temp})



if __name__=='__main__':
        app.run()
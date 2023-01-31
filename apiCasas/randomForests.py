from tokenize import Double, Number
from urllib import response
from fastapi import FastAPI;
from pydantic import BaseModel
import pickle
import pandas as pd
import numpy as np
import uvicorn


app=FastAPI()

forests_ml_model = pickle.load(open('rf_model.pkl','rb'))

class ForestsPredIn(BaseModel):
    BsmtFinSF1: int
    GarageYrBlt: int
    FirstFlrSF:int
    GarageArea: int
    TotalBsmtSF:int
    YearBuilt:int
    GarageCars:int
    GrLivArea:int
    OverallQual:int

class ForestsPredOut(BaseModel):
    precio_forest:float

@app.get('/')
def index():
    return{'mensaje':'Forests App'}

@app.post('/forests-predictions', response_model=ForestsPredOut, status_code=201)
def procesar_prediccion_forests(forests_pred_in:ForestsPredIn):

    input_values=[
    forests_pred_in.BsmtFinSF1,
    forests_pred_in.GarageYrBlt,
    forests_pred_in.FirstFlrSF,
    forests_pred_in.GarageArea,
    forests_pred_in.TotalBsmtSF,    
    forests_pred_in.YearBuilt,
    forests_pred_in.GarageCars,
    forests_pred_in.GrLivArea,
    forests_pred_in.OverallQual]

    features = [np.array(input_values)]
    features_df=pd.DataFrame(features)

    predicted_price = round(forests_ml_model.predict(features_df)[0],2)
    print(predicted_price)
    return ForestsPredOut(precio_forest=predicted_price)



    if __name__ == '__main__':
        uvicorn.run(app, host="0.0.0.0", port=8000, debug=True)

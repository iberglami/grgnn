import torch
import numpy as np
import pandas as pd


load_matrics = torch.load('')
load_matrics = load_matrics.cpu()
load_array = load_matrics.numpy()
print(type(load_array))
print(load_array.shape)
array_size = load_array.shape
temp = load_array[-1,:,:]
data = pd.DataFrame(temp)
row_size = array_size[-1]
colum_size = array_size[-2]
print(row_size)
print(colum_size)
aver = temp.sum()/colum_size
abs_aver = np.absolute(temp).sum()/colum_size
print(aver)
print(abs_aver)
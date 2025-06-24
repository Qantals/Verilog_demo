# coding:UTF-8
import numpy as np

def str2int8_list(str):
    str_list = str.rstrip().split("\n") # strip last LF; split string to list
    array = [int(x,base=2) for x in str_list] # deal with unsigned number
    array = [x if x<=127 else -((x - 1) ^ int("11111111", base=2)) for x in array] # deal with signed number
    return array

def compress(array):
    array = np.right_shift(array,8)
    array[array > 127] = 127 # use reference!
    array[array < -128] = -128
    return array



# open document
fdata = open("./sample/data.txt","r")
fweight = open("./sample/weight.txt","r")
foutput = open("./sample/output.txt","r")

# preprocess weight
weight_conv = str2int8_list(fweight.read())
weight_connect = np.asarray(weight_conv[3*3*3:],dtype=np.int32).reshape((3,3,3)) # divide into 2 parts
weight_conv =    np.asarray(weight_conv[:3*3*3],dtype=np.int32).reshape((3,3,3))

# preprocess data
data = str2int8_list(fdata.read())
data = [[x for x in data[i*64:(i+1)*64]] for i in range(100)] # divide into 100 pictures
data = [np.asarray(x, dtype=np.int32).reshape((8,8)) for x in data] # convert to ndarray

# preprocess output
output = str2int8_list(foutput.read())
output = [np.asarray(x, dtype=np.int32) for x in output]

for i in range(100):# select pictures

    # calculate convolution
    conv = np.zeros((3,6,6),dtype=np.int32)
    for d in range(3):
        for r in range(6):
            for c in range(6):
                conv[d,r,c] = np.vdot(data[i][r:(r+3),c:(c+3)], weight_conv[d,:,:])

    # get compressed
    conv = compress(conv)

    # calculate pool
    pool = np.zeros((3,3,3), dtype=np.int32)
    # for d in range(3):
    #     for r in range(3):
    #         for c in range(3):
    #             pool[d,r,c] = conv[d,2*r:(2*r+2),2*c:(2*c+2)].max()
    for r in range(3):
        for c in range(3):
            pool[:,[r],[c]] = conv[:,2*r:(2*r+2),2*c:(2*c+2)].max(axis=1).max(axis=1).reshape(3,1)
            # suggest left value to be slice for reference?

    # calculate connect
    connect = np.array([0])
    for d in range(3):
        connect += np.vdot(pool[d,:,:], weight_connect[d,:,:])

    # get compressed
    connect = compress(connect)

    # check answer
    if connect[0] == output[i]:
        print("No.{}:check OK. dout={:d}".format(i, output[i]))
    else:
        print("No.{}:check failed. dout={:d},ans={:d}".format(i, output[i], connect[0]))

# close document
fdata.close()
fweight.close()
foutput.close()

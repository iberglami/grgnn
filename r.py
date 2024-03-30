import os
import torch
os.environ['CUDA_VISIBLE_DEVICES'] = '0,1'
from datetime import datetime
from models.handler import train, test
import argparse
import pandas as pd

parser = argparse.ArgumentParser()
parser.add_argument('--train', type=bool, default=True)
parser.add_argument('--evaluate', type=bool, default=False)
parser.add_argument('--dataset', type=str, default='afri(smoothed)')
parser.add_argument('--window_size', type=int, default=15)
parser.add_argument('--horizon', type=int, default=1)
parser.add_argument('--train_length', type=float, default=21)
parser.add_argument('--valid_length', type=float, default=1)
parser.add_argument('--test_length', type=float, default=2)
parser.add_argument('--epoch', type=int, default=150)
parser.add_argument('--lr', type=float, default=4.7e-4)
parser.add_argument('--multi_layer', type=int, default=8)
parser.add_argument('--device', type=str, default='cuda:1')
parser.add_argument('--validate_freq', type=int, default=100)
parser.add_argument('--batch_size', type=int, default=15)
parser.add_argument('--norm_method', type=str, default='z_score')
parser.add_argument('--optimizer', type=str, default='Adam')
parser.add_argument('--early_stop', type=bool, default=False)
parser.add_argument('--exponential_decay_step', type=int, default=4)
parser.add_argument('--decay_rate', type=float, default=0.4)
parser.add_argument('--dropout_rate', type=float, default=0.4)
parser.add_argument('--leakyrelu_rate', type=int, default=0.2)


args = parser.parse_args()
print(f'Training configs: {args}')
data_file = os.path.join('dataset', args.dataset + '.csv')
result_train_file = os.path.join('output', args.dataset, 'train')
result_test_file = os.path.join('output', args.dataset, 'test')
if not os.path.exists(result_train_file):
    os.makedirs(result_train_file)
if not os.path.exists(result_test_file):
    os.makedirs(result_test_file)
data = pd.read_csv(data_file).values

# split data1
train_ratio = args.train_length / (args.train_length + args.valid_length + args.test_length)
valid_ratio = args.valid_length / (args.train_length + args.valid_length + args.test_length)
test_ratio = 1 - train_ratio - valid_ratio
train_data = data[:int(train_ratio * len(data))]
valid_data = data[int(train_ratio * len(data)):int((train_ratio + valid_ratio) * len(data))]
test_data = data[int((train_ratio + valid_ratio) * len(data)):]

# split data2
#train_data = data[:len(data)-4]
#valid_data = data[int(train_ratio * len(data)):int((train_ratio + valid_ratio) * len(data))]
#test_data = data[len(data))-4:]

torch.manual_seed(3407)
if __name__ == '__main__':
    if args.train:
        try:
            before_train = datetime.now().timestamp()
            _, normalize_statistic = train(train_data, valid_data, args, result_train_file)
            after_train = datetime.now().timestamp()
            print(f'Training took {(after_train - before_train) / 60} minutes')
        except KeyboardInterrupt:
            print('-' * 99)
            print('Exiting from training early')
    if args.evaluate:
        before_evaluation = datetime.now().timestamp()
        test(test_data, args, result_train_file, result_test_file)
        after_evaluation = datetime.now().timestamp()
        print(f'Evaluation took {(after_evaluation - before_evaluation) / 60} minutes')
    print('done')

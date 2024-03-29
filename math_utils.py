import numpy as np

def MAE(v, v_, axis=None):
    return np.mean(np.abs(v_ - v), axis).astype(np.float64)


def evaluate(y, y_hat, by_step=False, by_node=False):
    if not by_step and not by_node:
        return  MAE(y, y_hat)
    if by_step and by_node:
        return MAE(y, y_hat, axis=0)
    if by_step:
        return MAE(y, y_hat, axis=(0, 2))
    if by_node:
        return MAE(y, y_hat, axis=(0, 1))

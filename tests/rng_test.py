# to determine if an LFSR RNG would generate a uniform distribution

import numpy as np

class LFSR:
    def __init__(self, seed):
        self.state = seed

    def next(self):
        feedback = ((self.state >> 13) ^ (self.state >> 4) ^ (self.state >> 2) ^ (self.state >> 0)) & 1
        self.state = (self.state >> 1) | (feedback << 13)
        return self.state

lfsr = LFSR(0xc0e0)

values = []

for _ in range(100):
    values.append(lfsr.next()/(2**14))

# check mean and sd of generated values to estimate uniformity
print("Mean: " + str(np.mean(values)))
print("SD: " + str(np.std(values)))
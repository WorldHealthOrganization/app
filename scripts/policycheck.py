import sys
from profanity_check import predict_prob

min_prob = float(sys.argv[1])
ret = 0

for fn in sys.argv[2:]:
  with open(fn, 'r') as f:
    lines = f.readlines()
    ps = predict_prob(lines)
    for i in range(len(lines)):
      if ps[i] >= min_prob:
        print("L{} of {}:\n{}".format(i + 1, fn, lines[i]))
        ret = ret + 1

sys.exit(ret)

#!/bin/python

import hashlib
import sys
from profanity_check import predict_prob

def main(argv):
  min_prob = float(sys.argv[1])
  ret = 0

  with open(sys.argv[2], 'r') as f:
    ignoreds = f.readlines()
  ignoreds = [v.strip() for v in ignoreds]
  print(ignoreds)

  summary = ''
  for fn in sys.argv[3:]:
    with open(fn, 'r') as f:
      lines = f.readlines()
      ps = predict_prob(lines)
      for i in range(len(lines)):
        if ps[i] >= min_prob:
          keysrc = "{}\n{}".format(fn, lines[i]).encode()
          key = '{} {}'.format(hashlib.sha256(keysrc).hexdigest(), fn)
          summary += key +'\n'
          if key not in ignoreds:
            ret = ret + 1
            print("\n❌ L{} of {}:\n{}".format(i + 1, fn, lines[i][:-1]), file=sys.stderr)
            print("ℹ️  Add '{}' to {} to ignore this issue".format(key, sys.argv[2]), file=sys.stderr)
  print('\n\n\nSummary to ignore everything using {}:\n{}'.format(sys.argv[2], summary))
  return ret



if __name__ == "__main__":
  sys.exit(main(sys.argv))

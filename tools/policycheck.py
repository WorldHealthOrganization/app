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

  for fn in sys.argv[3:]:
    with open(fn, 'r') as f:
      lines = f.readlines()
      ps = predict_prob(lines)
      for i in range(len(lines)):
        if ps[i] >= min_prob:
          keysrc = "{}\n{}".format(fn, lines[i]).encode()
          key = '{} {}'.format(hashlib.sha256(keysrc).hexdigest(), fn)
          if key not in ignoreds:
            ret = ret + 1
            print("\n\n\n❌ L{} of {}:\n{}".format(i + 1, fn, lines[i]), file=sys.stderr)
            print("ℹ️ Add '{}' to {} to ignore this issue".format(key, sys.argv[2]), file=sys.stderr)
          else:
            print("\n\n\nℹ️ IGNORED: L{} of {}:\n{}".format(i + 1, fn, lines[i]))
            print("ℹ️ Remove '{}' from {} to stop ignoring this issue".format(key, sys.argv[2]))
  return ret



if __name__ == "__main__":
  sys.exit(main(sys.argv))

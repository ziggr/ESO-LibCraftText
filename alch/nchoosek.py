# import scipy.special.comb
# scipy.special.comb
from math import factorial

def comb(N,k):
    n_fact = factorial(N)
    k_fact = factorial(k)
    nk_fact = factorial(N-k)
    return n_fact / (k_fact * nk_fact)

# def comb(N,k): # from scipy.comb(), but MODIFIED!
#     if (k > N) or (N < 0) or (k < 0):
#         return 0
#     N,k = map(long,(N,k))
#     top = N
#     val = 1
#     while (top > (N-k)):
#         val *= top
#         top -= 1
#     n = 1
#     while (n < k+1):
#         val /= n
#         n += 1
#     return val

n28choose3 = comb(28,3)
print("28 choose 3: %d" % n28choose3)

n29choose3 = comb(29,3)
print("29 choose 3: %d" % n29choose3)

bigChoose = comb(n29choose3,26)
print("^ choose 26: %e" % bigChoose)

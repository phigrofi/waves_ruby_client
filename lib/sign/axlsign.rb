# frozen_string_literal: true

# Stupid ruby port from https://github.com/wavesplatform/curve25519-js/blob/master/axlsign.js

# Curve25519 signatures (and also key agreement)
# like in the early Axolotl.
#
# Written by Dmitry Chestnykh.
# You can use it under MIT or CC0 license.

# Curve25519 signatures idea and math by Trevor Perrin
# https://moderncrypto.org/mail-archive/curves/2014/000205.html

# Derived from TweetNaCl.js (https://tweetnacl.js.org/)
# Ported in 2014 by Dmitry Chestnykh and Devi Mandiri.
# Public domain.
#
# Implementation derived from TweetNaCl version 20140427.
# See for details: http://tweetnacl.cr.yp.to/

class Axlsign
  def self.gf(init = nil)
    r = Array.new(16, 0)
    (0..init.length - 1).each { |i| r[i] = init[i] } if init
    r
  end

  @_0 = []
  @_9 = []
  @_9[0] = 9

  @gf1 = gf([1])
  @gf0 = gf
  @D = gf([0x78a3, 0x1359, 0x4dca, 0x75eb, 0xd8ab, 0x4141, 0x0a4d, 0x0070, 0xe898, 0x7779, 0x4079, 0x8cc7, 0xfe73, 0x2b6f, 0x6cee, 0x5203])
  @D2 = gf([0xf159, 0x26b2, 0x9b94, 0xebd6, 0xb156, 0x8283, 0x149a, 0x00e0, 0xd130, 0xeef3, 0x80f2, 0x198e, 0xfce7, 0x56df, 0xd9dc, 0x2406])
  @X = gf([0xd51a, 0x8f25, 0x2d60, 0xc956, 0xa7b2, 0x9525, 0xc760, 0x692c, 0xdc5c, 0xfdd6, 0xe231, 0xc0a4, 0x53fe, 0xcd6e, 0x36d3, 0x2169])
  @Y = gf([0x6658, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666, 0x6666])

  def self.ts64(x, i, h, l) # >>
    x[i] = (h >> 24) & 0xff
    x[i + 1] = (h >> 16) & 0xff
    x[i + 2] = (h >> 8) & 0xff
    x[i + 3] = h & 0xff
    x[i + 4] = (l >> 24)  & 0xff
    x[i + 5] = (l >> 16)  & 0xff
    x[i + 6] = (l >> 8) & 0xff
    x[i + 7] = l & 0xff
    x
  end

  def self.set25519(r, a)
    (0..15).each { |i| r[i] = a[i] | 0 }
    r
  end

  def self.car25519(o)
    c = 1
    (0..15).each do |i|
      v = o[i] + c + 65_535
      c = (v.to_f / 65_536).floor
      o[i] = v - c * 65_536
    end
    o[0] += c - 1 + 37 * (c - 1)
    o
  end

  def self.sel25519(p, q, b)
    c = ~(b - 1)
    (0..15).each do |i|
      t = c & (p[i] ^ q[i])
      p[i] ^= t.to_i
      q[i] ^= t.to_i
    end
    [p, q]
  end

  def self.pack25519(o, n) # >>
    m = gf
    t = gf
    (0..15).each { |i| t[i] = n[i] }
    t = car25519(t)
    t = car25519(t)
    t = car25519(t)
    (0..1).each do |_j|
      m[0] = t[0] - 0xffed
      (1..14).each do |i|
        m[i] = t[i] - 0xffff - ((m[i - 1] >> 16) & 1)
        m[i - 1] &= 0xffff
      end
      m[15] = t[15] - 0x7fff - ((m[14] >> 16) & 1)
      b = (m[15] >> 16) & 1
      m[14] &= 0xffff
      t, m = sel25519(t, m, 1 - b)
    end
    (0..15).each do |i|
      o[2 * i] = t[i] & 0xff
      o[2 * i + 1] = t[i] >> 8
    end
    o
  end

  def self.par25519(a)
    d = []
    d = pack25519(d, a)
    d[0] & 1
  end

  def self.A(o, a, b)
    (0..15).each { |i| o[i] = a[i] + b[i] }
    o
  end

  def self.Z(o, a, b)
    (0..15).each { |i| o[i] = a[i] - b[i] }
    o
  end

  def self.M(o, a, b)
    t0 = 0
    t1 = 0
    t2 = 0
    t3 = 0
    t4 = 0
    t5 = 0
    t6 = 0
    t7 = 0
    t8 = 0
    t9 = 0
    t10 = 0
    t11 = 0
    t12 = 0
    t13 = 0
    t14 = 0
    t15 = 0
    t16 = 0
    t17 = 0
    t18 = 0
    t19 = 0
    t20 = 0
    t21 = 0
    t22 = 0
    t23 = 0
    t24 = 0
    t25 = 0
    t26 = 0
    t27 = 0
    t28 = 0
    t29 = 0
    t30 = 0
    b0 = b[0]
    b1 = b[1]
    b2 = b[2]
    b3 = b[3]
    b4 = b[4]
    b5 = b[5]
    b6 = b[6]
    b7 = b[7]
    b8 = b[8]
    b9 = b[9]
    b10 = b[10]
    b11 = b[11]
    b12 = b[12]
    b13 = b[13]
    b14 = b[14]
    b15 = b[15]

    v = a[0]
    t0 += v * b0
    t1 += v * b1
    t2 += v * b2
    t3 += v * b3
    t4 += v * b4
    t5 += v * b5
    t6 += v * b6
    t7 += v * b7
    t8 += v * b8
    t9 += v * b9
    t10 += v * b10
    t11 += v * b11
    t12 += v * b12
    t13 += v * b13
    t14 += v * b14
    t15 += v * b15
    v = a[1]
    t1 += v * b0
    t2 += v * b1
    t3 += v * b2
    t4 += v * b3
    t5 += v * b4
    t6 += v * b5
    t7 += v * b6
    t8 += v * b7
    t9 += v * b8
    t10 += v * b9
    t11 += v * b10
    t12 += v * b11
    t13 += v * b12
    t14 += v * b13
    t15 += v * b14
    t16 += v * b15
    v = a[2]
    t2 += v * b0
    t3 += v * b1
    t4 += v * b2
    t5 += v * b3
    t6 += v * b4
    t7 += v * b5
    t8 += v * b6
    t9 += v * b7
    t10 += v * b8
    t11 += v * b9
    t12 += v * b10
    t13 += v * b11
    t14 += v * b12
    t15 += v * b13
    t16 += v * b14
    t17 += v * b15
    v = a[3]
    t3 += v * b0
    t4 += v * b1
    t5 += v * b2
    t6 += v * b3
    t7 += v * b4
    t8 += v * b5
    t9 += v * b6
    t10 += v * b7
    t11 += v * b8
    t12 += v * b9
    t13 += v * b10
    t14 += v * b11
    t15 += v * b12
    t16 += v * b13
    t17 += v * b14
    t18 += v * b15
    v = a[4]
    t4 += v * b0
    t5 += v * b1
    t6 += v * b2
    t7 += v * b3
    t8 += v * b4
    t9 += v * b5
    t10 += v * b6
    t11 += v * b7
    t12 += v * b8
    t13 += v * b9
    t14 += v * b10
    t15 += v * b11
    t16 += v * b12
    t17 += v * b13
    t18 += v * b14
    t19 += v * b15
    v = a[5]
    t5 += v * b0
    t6 += v * b1
    t7 += v * b2
    t8 += v * b3
    t9 += v * b4
    t10 += v * b5
    t11 += v * b6
    t12 += v * b7
    t13 += v * b8
    t14 += v * b9
    t15 += v * b10
    t16 += v * b11
    t17 += v * b12
    t18 += v * b13
    t19 += v * b14
    t20 += v * b15
    v = a[6]
    t6 += v * b0
    t7 += v * b1
    t8 += v * b2
    t9 += v * b3
    t10 += v * b4
    t11 += v * b5
    t12 += v * b6
    t13 += v * b7
    t14 += v * b8
    t15 += v * b9
    t16 += v * b10
    t17 += v * b11
    t18 += v * b12
    t19 += v * b13
    t20 += v * b14
    t21 += v * b15
    v = a[7]
    t7 += v * b0
    t8 += v * b1
    t9 += v * b2
    t10 += v * b3
    t11 += v * b4
    t12 += v * b5
    t13 += v * b6
    t14 += v * b7
    t15 += v * b8
    t16 += v * b9
    t17 += v * b10
    t18 += v * b11
    t19 += v * b12
    t20 += v * b13
    t21 += v * b14
    t22 += v * b15
    v = a[8]
    t8 += v * b0
    t9 += v * b1
    t10 += v * b2
    t11 += v * b3
    t12 += v * b4
    t13 += v * b5
    t14 += v * b6
    t15 += v * b7
    t16 += v * b8
    t17 += v * b9
    t18 += v * b10
    t19 += v * b11
    t20 += v * b12
    t21 += v * b13
    t22 += v * b14
    t23 += v * b15
    v = a[9]
    t9 += v * b0
    t10 += v * b1
    t11 += v * b2
    t12 += v * b3
    t13 += v * b4
    t14 += v * b5
    t15 += v * b6
    t16 += v * b7
    t17 += v * b8
    t18 += v * b9
    t19 += v * b10
    t20 += v * b11
    t21 += v * b12
    t22 += v * b13
    t23 += v * b14
    t24 += v * b15
    v = a[10]
    t10 += v * b0
    t11 += v * b1
    t12 += v * b2
    t13 += v * b3
    t14 += v * b4
    t15 += v * b5
    t16 += v * b6
    t17 += v * b7
    t18 += v * b8
    t19 += v * b9
    t20 += v * b10
    t21 += v * b11
    t22 += v * b12
    t23 += v * b13
    t24 += v * b14
    t25 += v * b15
    v = a[11]
    t11 += v * b0
    t12 += v * b1
    t13 += v * b2
    t14 += v * b3
    t15 += v * b4
    t16 += v * b5
    t17 += v * b6
    t18 += v * b7
    t19 += v * b8
    t20 += v * b9
    t21 += v * b10
    t22 += v * b11
    t23 += v * b12
    t24 += v * b13
    t25 += v * b14
    t26 += v * b15
    v = a[12]
    t12 += v * b0
    t13 += v * b1
    t14 += v * b2
    t15 += v * b3
    t16 += v * b4
    t17 += v * b5
    t18 += v * b6
    t19 += v * b7
    t20 += v * b8
    t21 += v * b9
    t22 += v * b10
    t23 += v * b11
    t24 += v * b12
    t25 += v * b13
    t26 += v * b14
    t27 += v * b15
    v = a[13]
    t13 += v * b0
    t14 += v * b1
    t15 += v * b2
    t16 += v * b3
    t17 += v * b4
    t18 += v * b5
    t19 += v * b6
    t20 += v * b7
    t21 += v * b8
    t22 += v * b9
    t23 += v * b10
    t24 += v * b11
    t25 += v * b12
    t26 += v * b13
    t27 += v * b14
    t28 += v * b15
    v = a[14]
    t14 += v * b0
    t15 += v * b1
    t16 += v * b2
    t17 += v * b3
    t18 += v * b4
    t19 += v * b5
    t20 += v * b6
    t21 += v * b7
    t22 += v * b8
    t23 += v * b9
    t24 += v * b10
    t25 += v * b11
    t26 += v * b12
    t27 += v * b13
    t28 += v * b14
    t29 += v * b15
    v = a[15]
    t15 += v * b0
    t16 += v * b1
    t17 += v * b2
    t18 += v * b3
    t19 += v * b4
    t20 += v * b5
    t21 += v * b6
    t22 += v * b7
    t23 += v * b8
    t24 += v * b9
    t25 += v * b10
    t26 += v * b11
    t27 += v * b12
    t28 += v * b13
    t29 += v * b14
    t30 += v * b15

    t0  += 38 * t16
    t1  += 38 * t17
    t2  += 38 * t18
    t3  += 38 * t19
    t4  += 38 * t20
    t5  += 38 * t21
    t6  += 38 * t22
    t7  += 38 * t23
    t8  += 38 * t24
    t9  += 38 * t25
    t10 += 38 * t26
    t11 += 38 * t27
    t12 += 38 * t28
    t13 += 38 * t29
    t14 += 38 * t30
    # t15 left as is

    # first car
    c = 1
    v = t0 + c + 65_535
    c = (v.to_f / 65_536).floor
    t0 = v - c * 65_536
    v =  t1 + c + 65_535
    c = (v.to_f / 65_536).floor
    t1 = v - c * 65_536
    v =  t2 + c + 65_535
    c = (v.to_f / 65_536).floor
    t2 = v - c * 65_536
    v =  t3 + c + 65_535
    c = (v.to_f / 65_536).floor
    t3 = v - c * 65_536
    v =  t4 + c + 65_535
    c = (v.to_f / 65_536).floor
    t4 = v - c * 65_536
    v =  t5 + c + 65_535
    c = (v.to_f / 65_536).floor
    t5 = v - c * 65_536
    v =  t6 + c + 65_535
    c = (v.to_f / 65_536).floor
    t6 = v - c * 65_536
    v =  t7 + c + 65_535
    c = (v.to_f / 65_536).floor
    t7 = v - c * 65_536
    v = t8 + c + 65_535
    c = (v.to_f / 65_536).floor
    t8 = v - c * 65_536
    v =  t9 + c + 65_535
    c = (v.to_f / 65_536).floor
    t9 = v - c * 65_536
    v = t10 + c + 65_535
    c = (v.to_f / 65_536).floor
    t10 = v - c * 65_536
    v = t11 + c + 65_535
    c = (v.to_f / 65_536).floor
    t11 = v - c * 65_536
    v = t12 + c + 65_535
    c = (v.to_f / 65_536).floor
    t12 = v - c * 65_536
    v = t13 + c + 65_535
    c = (v.to_f / 65_536).floor
    t13 = v - c * 65_536
    v = t14 + c + 65_535
    c = (v.to_f / 65_536).floor
    t14 = v - c * 65_536
    v = t15 + c + 65_535
    c = (v.to_f / 65_536).floor
    t15 = v - c * 65_536

    t0 += c - 1 + 37 * (c - 1)

    # second car
    c = 1
    v = t0 + c + 65_535
    c = (v.to_f / 65_536).floor
    t0 = v - c * 65_536
    v =  t1 + c + 65_535
    c = (v.to_f / 65_536).floor
    t1 = v - c * 65_536
    v =  t2 + c + 65_535
    c = (v.to_f / 65_536).floor
    t2 = v - c * 65_536
    v =  t3 + c + 65_535
    c = (v.to_f / 65_536).floor
    t3 = v - c * 65_536
    v =  t4 + c + 65_535
    c = (v.to_f / 65_536).floor
    t4 = v - c * 65_536
    v =  t5 + c + 65_535
    c = (v.to_f / 65_536).floor
    t5 = v - c * 65_536
    v =  t6 + c + 65_535
    c = (v.to_f / 65_536).floor
    t6 = v - c * 65_536
    v =  t7 + c + 65_535
    c = (v.to_f / 65_536).floor
    t7 = v - c * 65_536
    v =  t8 + c + 65_535
    c = (v.to_f / 65_536).floor
    t8 = v - c * 65_536
    v =  t9 + c + 65_535
    c = (v.to_f / 65_536).floor
    t9 = v - c * 65_536
    v = t10 + c + 65_535
    c = (v.to_f / 65_536).floor
    t10 = v - c * 65_536
    v = t11 + c + 65_535
    c = (v.to_f / 65_536).floor
    t11 = v - c * 65_536
    v = t12 + c + 65_535
    c = (v.to_f / 65_536).floor
    t12 = v - c * 65_536
    v = t13 + c + 65_535
    c = (v.to_f / 65_536).floor
    t13 = v - c * 65_536
    v = t14 + c + 65_535
    c = (v.to_f / 65_536).floor
    t14 = v - c * 65_536
    v = t15 + c + 65_535
    c = (v.to_f / 65_536).floor
    t15 = v - c * 65_536

    t0 += c - 1 + 37 * (c - 1)

    o[0] = t0
    o[1] = t1
    o[2] = t2
    o[3] = t3
    o[4] = t4
    o[5] = t5
    o[6] = t6
    o[7] = t7
    o[8] = t8
    o[9] = t9
    o[10] = t10
    o[11] = t11
    o[12] = t12
    o[13] = t13
    o[14] = t14
    o[15] = t15
    o
  end

  def self.S(o, a)
    M(o, a, a)
  end

  def self.inv25519(o, i)
    c = gf
    (0..15).each { |a| c[a] = i[a] }
    (0..253).to_a.reverse.each do |a|
      c = S(c, c)
      c = M(c, c, i) if a != 2 && a != 4
    end
    (0..15).each { |a| o[a] = c[a] }
    o
  end

  @K = [
    0x428a2f98, 0xd728ae22, 0x71374491, 0x23ef65cd,
    0xb5c0fbcf, 0xec4d3b2f, 0xe9b5dba5, 0x8189dbbc,
    0x3956c25b, 0xf348b538, 0x59f111f1, 0xb605d019,
    0x923f82a4, 0xaf194f9b, 0xab1c5ed5, 0xda6d8118,
    0xd807aa98, 0xa3030242, 0x12835b01, 0x45706fbe,
    0x243185be, 0x4ee4b28c, 0x550c7dc3, 0xd5ffb4e2,
    0x72be5d74, 0xf27b896f, 0x80deb1fe, 0x3b1696b1,
    0x9bdc06a7, 0x25c71235, 0xc19bf174, 0xcf692694,
    0xe49b69c1, 0x9ef14ad2, 0xefbe4786, 0x384f25e3,
    0x0fc19dc6, 0x8b8cd5b5, 0x240ca1cc, 0x77ac9c65,
    0x2de92c6f, 0x592b0275, 0x4a7484aa, 0x6ea6e483,
    0x5cb0a9dc, 0xbd41fbd4, 0x76f988da, 0x831153b5,
    0x983e5152, 0xee66dfab, 0xa831c66d, 0x2db43210,
    0xb00327c8, 0x98fb213f, 0xbf597fc7, 0xbeef0ee4,
    0xc6e00bf3, 0x3da88fc2, 0xd5a79147, 0x930aa725,
    0x06ca6351, 0xe003826f, 0x14292967, 0x0a0e6e70,
    0x27b70a85, 0x46d22ffc, 0x2e1b2138, 0x5c26c926,
    0x4d2c6dfc, 0x5ac42aed, 0x53380d13, 0x9d95b3df,
    0x650a7354, 0x8baf63de, 0x766a0abb, 0x3c77b2a8,
    0x81c2c92e, 0x47edaee6, 0x92722c85, 0x1482353b,
    0xa2bfe8a1, 0x4cf10364, 0xa81a664b, 0xbc423001,
    0xc24b8b70, 0xd0f89791, 0xc76c51a3, 0x0654be30,
    0xd192e819, 0xd6ef5218, 0xd6990624, 0x5565a910,
    0xf40e3585, 0x5771202a, 0x106aa070, 0x32bbd1b8,
    0x19a4c116, 0xb8d2d0c8, 0x1e376c08, 0x5141ab53,
    0x2748774c, 0xdf8eeb99, 0x34b0bcb5, 0xe19b48a8,
    0x391c0cb3, 0xc5c95a63, 0x4ed8aa4a, 0xe3418acb,
    0x5b9cca4f, 0x7763e373, 0x682e6ff3, 0xd6b2b8a3,
    0x748f82ee, 0x5defb2fc, 0x78a5636f, 0x43172f60,
    0x84c87814, 0xa1f0ab72, 0x8cc70208, 0x1a6439ec,
    0x90befffa, 0x23631e28, 0xa4506ceb, 0xde82bde9,
    0xbef9a3f7, 0xb2c67915, 0xc67178f2, 0xe372532b,
    0xca273ece, 0xea26619c, 0xd186b8c7, 0x21c0c207,
    0xeada7dd6, 0xcde0eb1e, 0xf57d4f7f, 0xee6ed178,
    0x06f067aa, 0x72176fba, 0x0a637dc5, 0xa2c898a6,
    0x113f9804, 0xbef90dae, 0x1b710b35, 0x131c471b,
    0x28db77f5, 0x23047d84, 0x32caab7b, 0x40c72493,
    0x3c9ebe0a, 0x15c9bebc, 0x431d67c4, 0x9c100d4c,
    0x4cc5d4be, 0xcb3e42b6, 0x597f299c, 0xfc657e2a,
    0x5fcb6fab, 0x3ad6faec, 0x6c44198c, 0x4a475817
  ]

  def self.crypto_hashblocks_wh_wl(m, pos)
    wh = []
    wl = []
    (0..15).each do |i|
      j = 8 * i + pos
      mj = (0..7).to_a.map { |n| Int32.new(m[j + n].to_i) }
      wh[i] = (mj[0] << 24) | (mj[1] << 16) | (mj[2] << 8) | mj[3]
      wl[i] = (mj[4] << 24) | (mj[5] << 16) | (mj[6] << 8) | mj[7]
    end
    [wh, wl]
  end

  def self.crypto_hashblocks_hl(hh, hl, m, n)
    hh.map! { |v| Int32.new(v) }
    hl.map! { |v| Int32.new(v) }
    m.map! { |v| Int32.new(v) }

    ah = hh.dup
    al = hl.dup

    pos = 0
    while n >= 128

      wh, wl = crypto_hashblocks_wh_wl(m, pos)

      (0..79).each do |i|
        bh = ah.dup
        bl = al.dup

        # add
        h = ah[7].dup
        l = al[7].dup

        a = Int32.new(l & 0xffff)
        b = Int32.new(l).r_shift_pos(16)
        c = Int32.new(h & 0xffff)
        d = Int32.new(h).r_shift_pos(16)

        # Sigma1
        h = Int32.new((ah[4].r_shift_pos(14) | (al[4] << (32 - 14))) ^ (ah[4].r_shift_pos(18) | (al[4] << (32 - 18))) ^ (al[4].r_shift_pos((41 - 32)) | (ah[4] << (32 - (41 - 32)))))
        l = Int32.new((al[4].r_shift_pos(14) | (ah[4] << (32 - 14))) ^ (al[4].r_shift_pos(18) | (ah[4] << (32 - 18))) ^ (ah[4].r_shift_pos((41 - 32)) | (al[4] << (32 - (41 - 32)))))

        a += Int32.new(l & 0xffff)
        b += Int32.new(l).r_shift_pos(16)
        c += Int32.new(h & 0xffff)
        d += Int32.new(h).r_shift_pos(16)

        # Ch
        h = (ah[4] & ah[5]) ^ (~ah[4] & ah[6])
        l = (al[4] & al[5]) ^ (~al[4] & al[6])

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        # K
        h = Int32.new(@K[i * 2])
        l = Int32.new(@K[i * 2 + 1])

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        # w
        h = wh[i % 16]
        l = wl[i % 16]

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        b += a.r_shift_pos(16)
        c += b.r_shift_pos(16)
        d += c.r_shift_pos(16)

        th = c & 0xffff | d << 16
        tl = a & 0xffff | b << 16

        # add
        h = th
        l = tl

        a = l & 0xffff
        b = l.r_shift_pos(16)
        c = h & 0xffff
        d = h.r_shift_pos(16)

        # Sigma0
        h = (ah[0].r_shift_pos(28) | (al[0] << (32 - 28))) ^ (al[0].r_shift_pos((34 - 32)) | (ah[0] << (32 - (34 - 32)))) ^ (al[0].r_shift_pos((39 - 32)) | (ah[0] << (32 - (39 - 32))))
        l = (al[0].r_shift_pos(28) | (ah[0] << (32 - 28))) ^ (ah[0].r_shift_pos((34 - 32)) | (al[0] << (32 - (34 - 32)))) ^ (ah[0].r_shift_pos((39 - 32)) | (al[0] << (32 - (39 - 32))))

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        # Maj
        h = (ah[0] & ah[1]) ^ (ah[0] & ah[2]) ^ (ah[1] & ah[2])
        l = (al[0] & al[1]) ^ (al[0] & al[2]) ^ (al[1] & al[2])

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        b += a.r_shift_pos(16)
        c += b.r_shift_pos(16)
        d += c.r_shift_pos(16)

        bh[7] = (c & 0xffff) | (d << 16)
        bl[7] = (a & 0xffff) | (b << 16)

        # add
        h = bh[3]
        l = bl[3]

        a = l & 0xffff
        b = l.r_shift_pos(16)
        c = h & 0xffff
        d = h.r_shift_pos(16)

        h = th
        l = tl

        a += l & 0xffff
        b += l.r_shift_pos(16)
        c += h & 0xffff
        d += h.r_shift_pos(16)

        b += a.r_shift_pos(16)
        c += b.r_shift_pos(16)
        d += c.r_shift_pos(16)

        bh[3] = (c & 0xffff) | (d << 16)
        bl[3] = (a & 0xffff) | (b << 16)

        ah[0] = bh[7]
        ah[1..-1] = bh[0..-2]

        al[0] = bl[7]
        al[1..-1] = bl[0..-2]

        next unless i % 16 == 15
        (0..15).each do |j|
          # add
          h = wh[j]
          l = wl[j]

          a = Int32.new(l & 0xffff)
          b = Int32.new(l).r_shift_pos(16)
          c = Int32.new(h & 0xffff)
          d = Int32.new(h).r_shift_pos(16)

          h = wh[(j + 9) % 16]
          l = wl[(j + 9) % 16]

          a += l & 0xffff
          b += l.r_shift_pos(16)
          c += h & 0xffff
          d += h.r_shift_pos(16)

          # sigma0
          th = wh[(j + 1) % 16]
          tl = wl[(j + 1) % 16]
          h = (th.r_shift_pos(1) | (tl << (32 - 1))) ^ (th.r_shift_pos(8) | (tl << (32 - 8))) ^ th.r_shift_pos(7)
          l = (tl.r_shift_pos(1) | (th << (32 - 1))) ^ (tl.r_shift_pos(8) | (th << (32 - 8))) ^ (tl.r_shift_pos(7) | (th << (32 - 7)))

          a += l & 0xffff
          b += l.r_shift_pos(16)
          c += h & 0xffff
          d += h.r_shift_pos(16)

          # sigma1
          th = wh[(j + 14) % 16]
          tl = wl[(j + 14) % 16]
          h = (th.r_shift_pos(19) | (tl << (32 - 19))) ^ (tl.r_shift_pos((61 - 32)) | (th << (32 - (61 - 32)))) ^ th.r_shift_pos(6)

          l = (tl.r_shift_pos(19) | (th << (32 - 19))) ^ (th.r_shift_pos((61 - 32)) | (tl << (32 - (61 - 32)))) ^ (tl.r_shift_pos(6) | (th << (32 - 6)))

          a += l & 0xffff
          b += l.r_shift_pos(16)
          c += h & 0xffff
          d += h.r_shift_pos(16)

          b += a.r_shift_pos(16)
          c += b.r_shift_pos(16)
          d += c.r_shift_pos(16)

          wh[j] = (c & 0xffff) | (d << 16)
          wl[j] = (a & 0xffff) | (b << 16)
        end
      end

      hh, hl, ah, al = hh_hl_update(hh, hl, ah, al)

      pos += 128
      n -= 128
    end
    [hh, hl, m, n]
  end

  def self.hh_hl_update(hh, hl, ah, al)
    hh.map! { |v| Int32.new(v) }
    hl.map! { |v| Int32.new(v) }
    ah.map! { |v| Int32.new(v) }
    al.map! { |v| Int32.new(v) }
    (0..7).each do |n|
      h = ah[n]
      l = al[n]

      a = l & 0xffff
      b = l.r_shift_pos(16)
      c = h & 0xffff
      d = h.r_shift_pos(16)

      h = hh[n]
      l = hl[n]

      a += l & 0xffff
      b += l.r_shift_pos(16)
      c += h & 0xffff
      d += h.r_shift_pos(16)

      b += a.r_shift_pos(16)
      c += b.r_shift_pos(16)
      d += c.r_shift_pos(16)

      hh[n] = ah[n] = (c & 0xffff) | (d << 16)
      hl[n] = al[n] = (a & 0xffff) | (b << 16)
    end
    [hh, hl, ah, al]
  end

  def self.crypto_hash(out, m, n)
    hh = Array.new(8, 0)
    hl = Array.new(8, 0)
    x = Array.new(256, 0)
    b = n

    hh[0] = 0x6a09e667
    hh[1] = 0xbb67ae85
    hh[2] = 0x3c6ef372
    hh[3] = 0xa54ff53a
    hh[4] = 0x510e527f
    hh[5] = 0x9b05688c
    hh[6] = 0x1f83d9ab
    hh[7] = 0x5be0cd19

    hl[0] = 0xf3bcc908
    hl[1] = 0x84caa73b
    hl[2] = 0xfe94f82b
    hl[3] = 0x5f1d36f1
    hl[4] = 0xade682d1
    hl[5] = 0x2b3e6c1f
    hl[6] = 0xfb41bd6b
    hl[7] = 0x137e2179

    hh, hl, m, n = crypto_hashblocks_hl(hh, hl, m, n)
    n %= 128

    (0..n - 1).each { |i| x[i] = m[b - n + i] }
    x[n] = 128

    n = 256 - 128 * (n < 112 ? 1 : 0)
    x[n - 9] = 0
    x = ts64(x, n - 8, (b / 0x20000000) | 0, b << 3)

    hh, hl, m, n = crypto_hashblocks_hl(hh, hl, x, n)

    (0..7).each { |i| out = ts64(out, 8 * i, hh[i], hl[i]) }
    out.map { |v| Int32.new(v) }
  end

  def self.add(p, q)
    a = gf
    b = gf
    c = gf
    d = gf
    e = gf
    f = gf
    g = gf
    h = gf
    t = gf

    a = Z(a, p[1], p[0])
    t = Z(t, q[1], q[0])
    a = M(a, a, t)
    b = A(b, p[0], p[1])
    t = A(t, q[0], q[1])
    b = M(b, b, t)
    c = M(c, p[3], q[3])
    c = M(c, c, @D2)
    d = M(d, p[2], q[2])
    d = A(d, d, d)
    e = Z(e, b, a)
    f = Z(f, d, c)
    g = A(g, d, c)
    h = A(h, b, a)

    p[0] = M(p[0], e, f)
    p[1] = M(p[1], h, g)
    p[2] = M(p[2], g, f)
    p[3] = M(p[3], e, h)
    p
  end

  def self.cswap(p, q, b)
    (0..3).each do |i|
      p[i], q[i] = sel25519(p[i], q[i], b)
    end
    [p, q]
  end

  def self.pack(r, p)
    tx = gf
    ty = gf
    zi = gf
    zi = inv25519(zi, p[2])
    tx = M(tx, p[0], zi)

    ty = M(ty, p[1], zi)
    r = pack25519(r, ty)

    r[31] ^= par25519(tx) << 7
    r
  end

  def self.scalarmult(p, q, s)
    p[0] = set25519(p[0], @gf0)
    p[1] = set25519(p[1], @gf1)
    p[2] = set25519(p[2], @gf1)
    p[3] = set25519(p[3], @gf0)
    (0..255).to_a.reverse.each do |i|
      b = (s[(i / 8) | 0] >> (i & 7)) & 1 # >>
      p, q = cswap(p, q, b)
      q = add(q, p)
      p = add(p, p)
      p, q = cswap(p, q, b)
    end
    [p, q, s]
  end

  def self.scalarbase(p, s)
    q = [gf, gf, gf, gf]
    q[0] = set25519(q[0], @X)
    q[1] = set25519(q[1], @Y)
    q[2] = set25519(q[2], @gf1)
    q[3] = M(q[3], @X, @Y)
    p, q, s = scalarmult(p, q, s)
    [p, s]
  end

  @L = [0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58, 0xd6, 0x9c, 0xf7, 0xa2, 0xde, 0xf9, 0xde, 0x14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x10]

  def self.modL(r, x)
    r.map! { |v| Int32.new(v) }
    (32..63).to_a.reverse.each do |i|
      carry = 0
      k = i - 13
      jtemp = 0
      (i - 32..k).to_a.each do |j|
        jtemp = j + 1
        x[j] = x[j].to_i + carry - 16 * x[i].to_i * @L[j - (i - 32)]
        carry = (x[j] + 128) >> 8 # >>
        x[j] -= carry * 256
      end
      x[jtemp] += carry
      x[i] = 0
    end
    carry = 0
    (0..31).each do |j|
      x[j] += carry - (x[31].to_i >> 4) * @L[j] # >>
      carry = x[j] >> 8 # >>
      x[j] &= 255
    end
    (0..31).each { |j| x[j] -= carry * @L[j] }
    (0..31).each do |i|
      x[i + 1] += x[i].to_i >> 8 # >>
      r[i] = x[i] & 255
    end
    r
  end

  def self.reduce(r)
    x = []
    (0..63).each { |i| x[i] = r[i] }
    (0..63).each { |i| r[i] = 0 }
    r = modL(r, x)
    r
  end

  # Like crypto_sign, but uses secret key directly in hash.
  def self.crypto_sign_direct(sm, m, n, sk)
    h = []
    r = []
    x = []
    p = [gf, gf, gf, gf]

    (0..n - 1).each { |i| sm[64 + i] = m[i] }
    (0..31).each { |i| sm[32 + i] = sk[i] }

    r = crypto_hash(r, sm[32..-1], n + 32)
    r = reduce(r)
    p, r = scalarbase(p, r)
    sm = pack(sm, p)

    (0..31).each { |i| sm[i + 32] = sk[32 + i] }
    h = crypto_hash(h, sm, n + 64)
    h = reduce(h)

    (0..63).each { |i| x[i] = 0 }
    (0..31).each { |i| x[i] = r[i] }
    (0..31).each do |i|
      (0..31).each do |j|
        x[i + j] += (h[i] * sk[j]).to_i
      end
    end

    sm[32..-1] = modL(sm[32..-1], x)

    [sm, m, n + 64, sk]
  end

  # Note: sm must be n+128.
  def self.crypto_sign_direct_rnd(sm, m, n, sk, rnd)
    h = []
    r = []
    x = []
    p = [gf, gf, gf, gf]

    # Hash separation.
    sm[0] = 0xfe
    (0..31).each { |i| sm[i] = 0xff }

    # Secret key.
    (0..31).each { |i| sm[32 + i] = sk[i] }

    # Message.
    (0..n - 1).each { |i| sm[64 + i] = m[i] }

    # Random suffix.
    (0..63).each { |i| sm[n + 64 + i] = rnd[i] }

    r = crypto_hash(r, sm, n + 128)
    r = reduce(r)
    p, r = scalarbase(p, r)
    sm = pack(sm, p)

    (0..31).each { |i| sm[i + 32] = sk[32 + i] }
    h = crypto_hash(h, sm, n + 64)
    h = reduce(h)

    # Wipe out random suffix.
    (0..63).each { |i| sm[n + 64 + i] = 0 }

    (0..63).each { |i| x[i] = 0 }
    (0..31).each { |i| x[i] = r[i] }

    (0..31).each do |i|
      (0..31).each do |j|
        x[i + j] += h[i] * sk[j]
      end
    end

    sm[32..n + 63] = modL(sm[32..n + 63], x)

    [sm, m, n + 64, sk, rnd]
  end

  def self.curve25519_sign(sm, m, n, sk, opt_rnd)
    # If opt_rnd is provided, sm must have n + 128,
    # otherwise it must have n + 64 bytes.

    # Convert Curve25519 secret key into Ed25519 secret key (includes pub key).
    edsk = Array.new(64, 0)
    p = [gf, gf, gf, gf]

    (0..31).each { |i| edsk[i] = sk[i] }
    # Ensure private key is in the correct format.
    edsk[0] &= 248
    edsk[31] &= 127
    edsk[31] |= 64

    p, edsk = scalarbase(p, edsk)
    edsk[32..-1] = pack(edsk[32..-1], p)

    # Remember sign bit.
    signBit = edsk[63] & 128

    if opt_rnd
      sm, m, n, edsk, opt_rnd = crypto_sign_direct_rnd(sm, m, n, edsk, opt_rnd)
    else
      sm, m, smlen, edsk = crypto_sign_direct(sm, m, n, edsk)
    end

    # Copy sign bit from public key into signature.
    sm[63] |= signBit
    sm
  end

  def self.sign(secret_key, msg, opt_random = SecureRandom.random_bytes(64).bytes)
    raise 'wrong secret key length' if secret_key.length != 32
    if opt_random
      raise 'wrong random data length' if opt_random.length != 64
    end
    buf = []
    buf = curve25519_sign(buf, msg, msg.length, secret_key, opt_random)
    signature = []
    (0..63).each { |i| signature[i] = buf[i] }
    signature.map(&:to_i)
  end
end

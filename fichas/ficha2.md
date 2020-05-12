# Ficha 2 - Trandformações Geométricas

* ex 1a
```
glLookAt(0, sin(_&alpha), cos(_&alpha), 0,0,0, 0,1,0)
```

* ex 1b
```
glRotate(-_&alpha, 1, 0, 0)
glTranslate(0, -sin(_&alpha), -cos(-&alpha))
```

* ex 2

* ex 3a
```
vx = (l2 - p2)u3 - (l3 - p3)u2
vy = (l3 - p3)u1 - (l1 - p1)u3
vz = (l1 - p1)u2 - (l2 - p2)u1

glLookAt(p1 + vx, p2 + vy, p3 + vz, l1 + vx, l2 + vy, l3 + vz, u1, u2, u3);
```

* ex 3b
```
d = sqrt(u1*u1 + u2*u2 + u3*u3)
up1 = u1 / d
up2 = u2 / d
up3 = u3 / d

glLookAt(p1 + up1, p2 + up2, p3 + up3, l1 + up1, l2 + up2, l3 + up3, u1, u2, u3);
```

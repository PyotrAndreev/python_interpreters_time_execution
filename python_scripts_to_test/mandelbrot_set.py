def linspace(start, stop, n):
    if n == 1:
        yield stop
        return
    h = (stop - start) / (n - 1)
    for i in range(n):
        yield start + h * i

def mandelbrot(pmin = -2.5, pmax= 1.5, qmin = -2, qmax= 2,
                ppoints = 200, qpoints = 200, max_iterations = 300, infinity_border = 100):
    image = [[0 for i in range(qpoints)] for j in range(ppoints)]
    for ip, p in enumerate(linspace(pmin, pmax, ppoints)):
        for iq, q in enumerate(linspace(qmin, qmax, qpoints)):
            c = p + 1j * q
            z = 0
            for k in range(max_iterations):
                z = z ** 2 + c
                if abs(z) > infinity_border:
                    image[ip][iq] = 1
                    break
    return image


mandelbrot()

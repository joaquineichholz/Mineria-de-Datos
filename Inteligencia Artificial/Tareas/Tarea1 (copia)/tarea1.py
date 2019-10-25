import sys
from PyQt5.QtWidgets import QWidget, QApplication
from PyQt5.QtGui import QPainter, QColor, QPen
from PyQt5.QtCore import Qt, QPoint


class MiVentana(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Flow')
        self.title = 'Flow'
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(200, 100, 500, 500)

        # Set window background color
        self.setAutoFillBackground(True)
        p = self.palette()
        p.setColor(self.backgroundRole(), Qt.black)
        self.setPalette(p)

        # Add paint widget and paint
        self.m = PaintWidget(self)
        self.m.move(0, 0)
        self.m.resize(500, 500)
        self.show()


class PaintWidget(QWidget):
    colors = {'petroleo': QColor(56, 129, 127),
             'burdeo': QColor(162, 43, 46),
             'rosa2': QColor(234, 65, 248),
             'azul': QColor(15, 41, 244),
             'azul_oscuro': QColor(3, 18, 137),
             'gris': QColor(166, 165, 166),
             'morado': QColor(126, 30, 126),
             'verde_claro': QColor(116, 248, 76),
             'amarillo': QColor(237, 234, 78),
             'fucsia': QColor(234, 56, 147),
             'blanco': QColor(255, 255, 255),
             'verde_oscuro': QColor(57, 129, 35),
             'verde': QColor(116, 248, 76),
             'rojo': QColor(245, 52, 0),
             'cafe_claro': QColor(189, 181, 112),
             'naranjo': QColor(239, 125, 49),
             'celeste': QColor(115, 251, 253)}

    # resultado ejemplo 5x5
    # resultado = 'color(azul,5,1) color(azul,5,3) color(blanco,5,4) color(blanco,4,5) color(verde,4,1) color(verde,3,1) color(amarillo,3,3) color(amarillo,3,4) color(morado,2,4) color(morado,3,5) camino(azul,5,2,5,1) camino(blanco,5,5,4,5) camino(verde,2,1,3,1) camino(amarillo,4,3,3,3) camino(morado,2,5,3,5) camino(azul,5,3,5,2) camino(blanco,5,4,5,5) camino(verde,4,1,4,2) camino(amarillo,3,4,4,4) camino(morado,2,4,2,3) camino(morado,1,4,1,5) camino(morado,2,3,1,3) camino(verde,3,2,2,2) camino(verde,4,2,3,2) camino(amarillo,4,4,4,3) camino(verde,1,1,2,1) camino(verde,2,2,1,2) camino(morado,1,3,1,4) camino(morado,1,5,2,5) camino(verde,1,2,1,1)'
    # resultado ejemplo bonus 15x15
    #resultado = 'color(blanco,1,4) color(cafe_claro,1,9) color(rosa2,1,14) color(morado,1,15) color(azul,2,7) color(verde_oscuro,2,8) color(rosa2,2,9) color(cafe_claro,2,10) color(naranjo,3,8) color(celeste,3,14) color(rojo,3,15) color(azul,4,3) color(verde_oscuro,5,2) color(burdeo,5,7) color(fucsia,5,15) color(petroleo,6,4) color(burdeo,6,5) color(azul_oscuro,7,12) color(fucsia,7,15) color(amarillo,8,8) color(morado,8,9) color(amarillo,9,7) color(verde_claro,9,13) color(celeste,10,5) color(naranjo,10,13) color(azul_oscuro,11,13) color(gris,12,8) color(verde_claro,12,14) color(rojo,12,15) color(gris,13,3) color(petroleo,14,14) color(blanco,15,10) camino(blanco,15,9,15,10) camino(cafe_claro,1,10,2,10) camino(rosa2,3,9,2,9) camino(morado,2,15,1,15) camino(azul,2,6,2,7) camino(verde_oscuro,1,8,2,8) camino(naranjo,10,12,10,13) camino(celeste,9,5,10,5) camino(rojo,11,15,12,15) camino(burdeo,5,5,6,5) camino(fucsia,6,15,5,15) camino(petroleo,7,4,6,4) camino(azul_oscuro,7,11,7,12) camino(amarillo,9,8,8,8) camino(verde_claro,9,14,9,13) camino(gris,13,8,12,8) camino(blanco,1,4,1,3) camino(cafe_claro,1,9,1,10) camino(rosa2,1,14,1,13) camino(naranjo,3,8,3,7) camino(celeste,3,14,3,13) camino(rojo,3,15,4,15) camino(azul,4,3,3,3) camino(verde_oscuro,5,2,4,2) camino(burdeo,5,7,5,6) camino(fucsia,7,15,6,15) camino(morado,8,9,9,9) camino(amarillo,9,7,9,8) camino(azul_oscuro,11,13,11,12) camino(verde_claro,12,14,11,14) camino(gris,13,3,13,4) camino(petroleo,14,14,14,13) camino(gris,13,4,13,5) camino(naranjo,13,2,14,2) camino(naranjo,14,3,14,4) camino(petroleo,12,3,11,3) camino(petroleo,12,9,11,9) camino(petroleo,12,7,12,6) camino(petroleo,11,8,11,7) camino(naranjo,9,12,10,12) camino(naranjo,8,13,8,12) camino(celeste,9,6,9,5) camino(morado,10,7,10,6) camino(celeste,8,7,8,6) camino(celeste,7,8,7,7) camino(verde_claro,11,14,10,14) camino(azul_oscuro,11,12,11,11) camino(naranjo,12,13,12,12) camino(naranjo,7,13,8,13) camino(naranjo,8,12,9,12) camino(naranjo,6,12,6,13) camino(naranjo,14,15,13,15) camino(petroleo,14,13,14,12) camino(naranjo,15,14,15,15) camino(naranjo,13,14,13,13) camino(naranjo,6,3,6,2) camino(naranjo,5,4,5,3) camino(rojo,7,14,8,14) camino(rojo,8,15,9,15) camino(rojo,5,14,6,14) camino(morado,6,6,6,7) camino(morado,7,5,7,6) camino(morado,5,8,4,8) camino(burdeo,5,6,5,5) camino(morado,6,7,6,8) camino(naranjo,4,7,4,6) camino(naranjo,13,15,13,14) camino(rojo,4,15,4,14) camino(morado,10,6,11,6) camino(morado,10,4,9,4) camino(morado,11,5,11,4) camino(celeste,3,13,4,13) camino(rojo,4,14,5,14) camino(verde_claro,10,14,9,14) camino(morado,4,8,4,9) camino(blanco,5,1,6,1) camino(naranjo,6,2,7,2) camino(naranjo,4,4,5,4) camino(verde_oscuro,4,2,3,2) camino(naranjo,5,3,6,3) camino(azul,3,3,3,4) camino(naranjo,3,7,4,7) camino(verde_oscuro,1,7,1,8) camino(naranjo,8,10,7,10) camino(morado,9,9,10,9) camino(celeste,7,9,7,8) camino(rosa2,1,13,1,12) camino(morado,2,14,2,15) camino(rosa2,2,11,3,11) camino(rosa2,3,10,3,9) camino(naranjo,15,11,15,12) camino(naranjo,14,10,14,11) camino(verde_oscuro,1,5,1,6) camino(blanco,1,3,1,2) camino(verde_oscuro,2,4,2,5) camino(blanco,1,2,1,1) camino(petroleo,13,10,13,9) camino(blanco,15,8,15,9) camino(naranjo,14,9,14,10) camino(naranjo,15,12,15,13) camino(naranjo,14,11,15,11) camino(morado,4,10,4,11) camino(morado,2,12,2,13) camino(rosa2,3,11,3,10) camino(rosa2,1,11,2,11) camino(rosa2,1,12,1,11) camino(celeste,6,9,7,9) camino(morado,10,9,10,8) camino(naranjo,9,10,8,10) camino(verde_oscuro,2,5,1,5) camino(azul,3,6,2,6) camino(verde_oscuro,1,6,1,7) camino(verde_oscuro,2,3,2,4) camino(verde_oscuro,3,2,2,2) camino(azul,3,4,3,5) camino(naranjo,7,2,8,2) camino(blanco,6,1,7,1) camino(blanco,4,1,5,1) camino(morado,4,9,4,10) camino(azul_oscuro,10,11,9,11) camino(morado,3,12,2,12) camino(celeste,4,13,5,13) camino(morado,2,13,2,14) camino(petroleo,12,5,12,4) camino(petroleo,10,3,9,3) camino(morado,11,4,10,4) camino(morado,9,4,8,4) camino(morado,11,6,11,5) camino(rojo,10,15,11,15) camino(naranjo,4,6,4,5) camino(celeste,5,9,6,9) camino(naranjo,4,5,4,4) camino(morado,8,5,7,5) camino(morado,7,6,6,6) camino(celeste,5,13,5,12) camino(rojo,6,14,7,14) camino(morado,8,4,8,5) camino(petroleo,7,3,7,4) camino(petroleo,14,12,13,12) camino(naranjo,15,13,15,14) camino(naranjo,15,15,14,15) camino(celeste,5,12,5,11) camino(naranjo,7,10,6,10) camino(azul_oscuro,8,11,7,11) camino(naranjo,6,11,6,12) camino(naranjo,6,13,7,13) camino(naranjo,13,13,12,13) camino(azul_oscuro,11,11,10,11) camino(naranjo,12,12,12,11) camino(morado,6,8,5,8) camino(celeste,7,7,8,7) camino(celeste,8,6,9,6) camino(azul_oscuro,9,11,8,11) camino(rojo,9,15,10,15) camino(rojo,8,14,8,15) camino(morado,10,8,10,7) camino(naranjo,14,8,14,9) camino(petroleo,12,6,12,5) camino(gris,13,7,13,8) camino(petroleo,11,7,12,7) camino(naranjo,12,10,11,10) camino(petroleo,13,9,12,9) camino(petroleo,11,9,11,8) camino(petroleo,11,3,10,3) camino(blanco,15,3,15,4) camino(blanco,13,1,14,1) camino(naranjo,14,2,14,3) camino(naranjo,12,2,13,2) camino(gris,13,5,13,6) camino(naranjo,14,4,14,5) camino(petroleo,12,4,12,3) camino(naranjo,14,5,14,6) camino(blanco,14,1,15,1) camino(blanco,12,1,13,1) camino(blanco,15,4,15,5) camino(blanco,15,2,15,3) camino(naranjo,11,2,12,2) camino(gris,13,6,13,7) camino(naranjo,14,7,14,8) camino(naranjo,11,10,10,10) camino(naranjo,12,11,12,10) camino(celeste,5,11,5,10) camino(petroleo,13,12,13,11) camino(petroleo,8,3,7,3) camino(naranjo,10,2,11,2) camino(petroleo,9,3,8,3) camino(morado,4,12,3,12) camino(blanco,7,1,8,1) camino(naranjo,8,2,9,2) camino(blanco,3,1,4,1) camino(azul,3,5,3,6) camino(naranjo,10,10,9,10) camino(naranjo,6,10,6,11) camino(morado,4,11,4,12) camino(celeste,5,10,5,9) camino(blanco,15,7,15,8) camino(petroleo,13,11,13,10) camino(blanco,1,1,2,1) camino(verde_oscuro,2,2,2,3) camino(blanco,15,6,15,7) camino(blanco,2,1,3,1) camino(blanco,8,1,9,1) camino(blanco,10,1,11,1) camino(naranjo,9,2,10,2) camino(blanco,11,1,12,1) camino(blanco,15,1,15,2) camino(naranjo,14,6,14,7) camino(blanco,15,5,15,6) camino(blanco,9,1,10,1)'
    resultado = input('resultado clingo color(C, Y, X) y camino(C, Y1, X1, Y2, X2): ')


    def paintEvent(self, event):
        qp = QPainter(self)
        qp.setPen(QPen(QColor(240, 240, 200), 2, Qt.SolidLine))
        qp.drawRect(20, 20, 450, 450)
        qp.setPen(QPen(QColor(240, 240, 200), .5, Qt.SolidLine))
        for i in range(1, 15):
            h_inicio = QPoint(20 + 30*i, 20)
            h_fin = QPoint(20 + 30*i, 470)
            qp.drawLine(h_inicio, h_fin)
            v_inicio = QPoint(20, 20 + 30*i)
            v_fin = QPoint(470, 20 + 30 * i)
            qp.drawLine(v_inicio, v_fin)
        self.paintCircles(qp)
        self.paintCaminos(qp)

    def paintCircles(self, qp):
        for c, y, x in self.puntos_inicio():
            color = self.colors[c]
            qp.setPen(QPen(color, 15, Qt.SolidLine, Qt.RoundCap, Qt.RoundJoin))
            punto = QPoint(35 + 30 * (x - 1), 455 - 30 * (y - 1))
            qp.drawPoint(punto)

    def paintCaminos(self, qp):
        for c, y1, x1, y2, x2 in self.caminos():
            color = self.colors[c]
            p_inicio= QPoint(35 + 30 * (x1 - 1), 455 - 30 * (y1 - 1))
            p_fin = QPoint(35 + 30 * (x2 - 1), 455 - 30 * (y2 - 1))
            qp.setPen(QPen(color, 7, Qt.SolidLine, Qt.RoundCap, Qt.RoundJoin))
            qp.drawLine(p_inicio, p_fin)

    def puntos_inicio(self):
        puntos = []
        resultados = self.resultado.split(' ')
        for r in resultados:
            if 'color' in r:
                c = r.replace('color(', '').replace(')', '').split(',')
                puntos.append([c[0], int(c[1]), int(c[2])])
        return puntos

    def caminos(self):
        caminos = []
        resultados = self.resultado.split(' ')
        for r in resultados:
            if 'camino' in r:
                c = r.replace('camino(', '').replace(')', '').split(',')
                caminos.append([c[0], int(c[1]), int(c[2]), int(c[3]), int(c[4])])
        return caminos



print('Los resultados muy largos (bonus) mejor ponerlos en la linea 54!!!')

if __name__ == '__main__':
    while True:
        app = QApplication(sys.argv)
        window = MiVentana()
        window.show()
        sys.exit(app.exec_())



# colores para ejemplo 5x5
"""
color(azul, 5, 1).
color(azul, 5, 3).
color(blanco, 5, 4).
color(blanco, 4, 5).
color(verde, 4, 1).
color(verde, 3, 1).
color(amarillo, 3, 3).
color(amarillo, 3, 4).
color(morado, 2, 4).
color(morado, 3, 5).
"""

# colores para bonus 15x15
"""
color(blanco,1,4).
color(cafe_claro,1,9).
color(rosa2,1,14).
color(morado,1,15).
color(azul,2,7).
color(verde_oscuro,2,8).
color(rosa2,2,9).
color(cafe_claro,2,10).
color(naranjo,3,8).
color(celeste,3,14).
color(rojo,3,15).
color(azul,4,3).
color(verde_oscuro,5,2).
color(burdeo,5,7).
color(fucsia,5,15).
color(petroleo,6,4).
color(burdeo,6,5).
color(azul_oscuro,7,12).
color(fucsia,7,15).
color(amarillo,8,8).
color(morado,8,9).
color(amarillo,9,7).
color(verde_claro,9,13).
color(celeste,10,5).
color(naranjo,10,13).
color(azul_oscuro,11,13).
color(gris,12,8).
color(verde_claro,12,14).
color(rojo,12,15).
color(gris,13,3).
color(petroleo,14,14).
color(blanco,15,10).
"""

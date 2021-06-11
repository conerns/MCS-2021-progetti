import tkinter as tk  # from tkinter import Tk for Python 3.x
from tkinter import filedialog
import pygubu
import os
import pathlib
from scipy import fft
import numpy as np
from PIL import Image, ImageTk


def render_image(F, d, self):
    image = self.to_process
    matrice = np.array(image)
    # questa è una prova fatta su tutta la matrice
    print("dimensione iniziale: ", matrice.shape)
    F = int(F)
    d = int(d)
    if 0 <= F <= min(matrice.shape) and 0 <= d <= (2 * F - 2):

        nrighe = int(matrice.shape[0] / F)
        ncolonne = int(matrice.shape[1] / F)
        righeDaTogliere = matrice.shape[0] % F
        colonneDaTogliere = matrice.shape[1] % F
        #print(righeDaTogliere, colonneDaTogliere)
        if righeDaTogliere != 0:
            matrice = matrice[:-righeDaTogliere, :]
        if colonneDaTogliere != 0:
            matrice = matrice[:, :-colonneDaTogliere]

        print("dimensione finale: ", matrice.shape)
        blocco = []

        for i in range(nrighe):
            for j in range(ncolonne):
                blocco = matrice[i * F:(i + 1) * F, j * F:(j + 1) * F]
                # print(modifico)
                x = fft.dctn(blocco, norm="ortho", type=2)
                for k in range(x.shape[0]):
                    for l in range(x.shape[1]):
                        if k + l >= d:
                            x[k][l] = 0
                y = fft.idctn(x, norm="ortho", type=2)
                for k in range(y.shape[0]):
                    for l in range(y.shape[1]):
                        y[k][l] = round(y[k][l])
                        if y[k][l] < 0:
                            y[k][l] = 0
                        if y[k][l] > 255:
                            y[k][l] = 255
                matrice[i * F:(i + 1) * F, j * F:(j + 1) * F] = y
        ricostruire = Image.fromarray(matrice)
        ricostruire.save("finale.bmp")
        ricostruire.show()
        self.show_img = ImageTk.PhotoImage(ricostruire)
        canvas = self.builder.get_object('canvas2')
        canvas.create_image(5, 5, anchor='nw', image=self.show_img)
    else:
        print("valori di F e d errati")


class Application:
    def __init__(self, master):
        self.master = master
        print(pathlib.Path(__file__).parent.absolute())
        self.builder = builder = pygubu.Builder()
        builder.add_from_file(
            str(pathlib.Path(__file__).parent.absolute())+"/interfaccia_grafica.ui")
        self.mainwindow = builder.get_object('frame_schermata', master)
        builder.connect_callbacks(self)

    def on_browse_button(self):
        filename = filedialog.askopenfilename(
            filetypes=[("Bitmap files", ".bmp")])
        # i need container
        canvas = self.builder.get_object('canvas1')
        # Load image in canvas
        image_to_display = Image.open(filename)
        # https://stackoverflow.com/questions/64851748/tkinter-python-converting-an-image-to-black-and-white
        image_to_display = image_to_display.convert("L")
        image_to_display.thumbnail((460, 460))
        self.to_process = image_to_display
        self.img = ImageTk.PhotoImage(image_to_display)
        canvas.create_image(5, 5, anchor='nw', image=self.img)

    def on_process_button(self):
        d_value = self.builder.get_object('entry_d').get()
        f_value = self.builder.get_object('entry_f').get()
        render_image(f_value, d_value, self)


if __name__ == '__main__':
    root = tk.Tk()
    root.title("Applicazione DCT2")
    root.withdraw()
    color = "#ADAABB"
    app = Application(root)
    root.mainloop()

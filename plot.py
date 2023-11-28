import sys
import os
import matplotlib.pyplot as plt
import numpy as np
import time
import matplotlib as mpl

try:
    mpl.use('TkAgg')
except:
    print("---Matplotlib error")
np.set_printoptions(precision=3, suppress=True)


def clear_line(line):
    if len(line) < 5:
        return line
    while line[4] not in ["x", "y", "z"]:
        end = line.find(" ")
        line = line[end + 1:]
        if len(line) < 5:
            return line
    return line


def read_joint(line, joint_num):
    coords = []
    if joint_num == 2:
        num_coords = 2
    else:
        num_coords = 3

    for _ in range(num_coords):
        begin = line.find("=")
        end = line.find(" ")
        num = line[begin + 1:end]
        coords.append(float(num))
        line = line[end + 1:]

    if joint_num == 2:
        coords.append(131.56)

    line = clear_line(line)
    return coords, line


plt.ion()
fig = plt.figure()

MIN_X = 0
MIN_Y = 0
MAX_X = 0
MAX_Y = 0

if len(sys.argv) > 1:
    folder = str(sys.argv[1])
else:
    folder = ""
file_path = folder + "6dop_p.pddl_search_gbfs_h_hadd_break_ties_arbitrary.npt"

if not os.path.exists(file_path):
    print("\nFILE NOT FOUND!\nInput name of folder with backslash. Ex: \'folder\\\'")
else:
    with open(file_path) as f:
        lines = f.readlines()
        for lin_idx in range(0, len(lines), 2):
            joints_list = [[0, 0, 0], [0, 0, 131.56]]
            line = lines[lin_idx]
            for i in range(2, 10):
                coords, line = read_joint(line, i)
                MIN_X = min(coords[0], MIN_X)
                MIN_Y = min(coords[1], MIN_Y)
                MAX_X = max(coords[0], MAX_X)
                MAX_Y = max(coords[1], MAX_Y)

    min_axis = min(MIN_X, MIN_Y)
    max_axis = max(MAX_X, MAX_Y)

    with open(file_path) as f:
        lines = f.readlines()
        for lin_idx in range(0, len(lines), 2):
            joints_list = [[0, 0, 0], [0, 0, 131.56]]
            line = lines[lin_idx]
            for i in range(2, 10):
                coords, line = read_joint(line, i)
                joints_list.append(coords)

            ax = fig.add_subplot(111, projection='3d')
            ax.set_xlim(min_axis, max_axis)
            ax.set_ylim(min_axis, max_axis)
            ax.set_zlim(0, 493)
            for i in range(len(joints_list) - 1):
                xs = [joints_list[i][0], joints_list[i + 1][0]]
                ys = [joints_list[i][1], joints_list[i + 1][1]]
                zs = [joints_list[i][2], joints_list[i + 1][2]]

                # Plot contour curves
                ax.plot(xs, ys, zs)

            plt.show()
            plt.pause(0.0001)
            fig.clf()

        time.sleep(5)
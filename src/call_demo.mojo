import sys.ffi
from sys.ffi import *
from time import sleep
from time import perf_counter_ns
import math


fn main():
    alias init_graphics = external_call["init_graphics", Int]
    alias draw_triangle = external_call[
        "draw_triangle", NoneType, Float32, Float32, Float32, Float32
    ]
    alias shutdown_graphics = external_call["shutdown_graphics", NoneType]
    print("<calling statically-linked aliased functions from mojo>")
    if not init_graphics():
        print("Failed to initialize graphics!")
        return

    fn spinny_triangle():
        var a: Float32 = 0
        var _nstime: UInt = perf_counter_ns()
        while True:
            print("--------------------")
            print("a: " + str(a))
            var r = ((math.cos(a / 2 / math.pi) / 2) + 0.5)

            print("r: " + str(r))
            draw_triangle(
                a,
                r,
                r,
                r,
            )
            print("--------------------")
            a += 1
            if a >= 360:
                var _elapsed: UInt = perf_counter_ns() - _nstime
                fps = 1 / (_elapsed // 1000 // 1000 / 1000) * 360
                print(
                    "time after 360 calls: "
                    + str(_elapsed // 1000 // 1000 / 1000)
                )
                if not fps == fps.MAX:
                    print("FPS: " + str(fps))
                a = 0
                _nstime = perf_counter_ns()

    spinny_triangle()

    shutdown_graphics()
    print("Goodbye, world!")

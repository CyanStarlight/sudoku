#include <stdio.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include <time.h>

static GLFWwindow *window;

int init_graphics()
{
    if (!glfwInit())
    {
        return 0;
    }
    window = glfwCreateWindow(800, 600, "Spinning Triangle", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return 0;
    }
    glfwMakeContextCurrent(window);
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    printf("init_graphics\n");
    return 1;
}

float time_self(int reference)
{
    clock_t now = clock();
    clock_t diff = now - reference;
    float fps = diff;
    return fps;
}

void draw_number_square(float x, float y, float size, float value, float max_value)
{
    float r = value / max_value; // Use value for red channel
    float g = 0.2f;              // Fixed green
    float b = 0.2f;              // Fixed blue

    glBegin(GL_QUADS);
    glColor3f(r, g, b);
    glVertex2f(x, y);
    glVertex2f(x + size, y);
    glVertex2f(x + size, y + size);
    glVertex2f(x, y + size);
    glEnd();
}

void draw_sudoku_grid(int *grid, int size, float cell_size)
{
    glClear(GL_COLOR_BUFFER_BIT);

    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            float x = (j - size / 2.0f) * cell_size;
            float y = (i - size / 2.0f) * cell_size;

            if (grid[i * size + j] > 0)
            {
                draw_number_square(x, y, cell_size * 0.9f,
                                   grid[i * size + j], size);
            }
        }
    }

    glfwSwapBuffers(window);
}
// main.c
#include <Python.h>

int main() {
    PyObject *pName, *pModule, *pFunc;
    PyObject *pArgs, *pValue;

    // Initialize Python Interpreter
    Py_Initialize();

    // Add current directory to Python path
    PyRun_SimpleString("import sys\n"
                       "sys.path.append(\".\")");

    // Import the calculate module
    pName = PyUnicode_DecodeFSDefault("calculate_wrapper");
    pModule = PyImport_Import(pName);
    Py_DECREF(pName);

    if (pModule != NULL) {
        // Get reference to the calculate function
        pFunc = PyObject_GetAttrString(pModule, "calculate");

        if (pFunc && PyCallable_Check(pFunc)) {
            // Prepare arguments
            pArgs = PyTuple_New(2);
            PyTuple_SetItem(pArgs, 0, PyLong_FromLong(10));
            PyTuple_SetItem(pArgs, 1, PyLong_FromLong(20));

            // Call the function
            pValue = PyObject_CallObject(pFunc, pArgs);
            Py_DECREF(pArgs);

            if (pValue != NULL) {
                printf("Result of calculation: %ld\n", PyLong_AsLong(pValue));
                Py_DECREF(pValue);
            }
            else {
                Py_DECREF(pFunc);
                Py_DECREF(pModule);
                PyErr_Print();
                fprintf(stderr, "Call failed\n");
                return 1;
            }
        }
        else {
            if (PyErr_Occurred())
                PyErr_Print();
            fprintf(stderr, "Cannot find function\n");
        }
        Py_XDECREF(pFunc);
        Py_DECREF(pModule);
    }
    else {
        PyErr_Print();
        fprintf(stderr, "Failed to load module\n");
        return 1;
    }
    // Clean up
    Py_Finalize();
    return 0;
}

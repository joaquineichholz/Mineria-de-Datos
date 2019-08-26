int* foo3();
    {
        int* a = malloc(sizeof(int) * 3)       
        return &i;
    }

int* init_array(in size)
{
    int* a = malloc(sizeof(int) * size)
}

int main(int argc, char const *argv[])
{
    int* a = init_array(10);


    int size = 10;

    for (int i = 0; i < size; i++ )
    {
        printf("%d\n", a[i])
    }  

};

#include <iostream>
#include <cstdlib>
#include <cassert>

template<class class_type,class data_type1,class data_type2>
char* access_order(data_type1 class_type::*mem1,data_type2 class_type::*mem2)
{
    assert ( mem1 != mem2 );
    return mem1 < mem2 ? "member 1 occurs first" : "member 2 occurs first";
}

struct X {
    float a;
    float b;
};

int main()
{
    std::cout << access_order(&X::a,&X::b) << std::endl;
    return 0;
}

package com.example.sample_webapp;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class DemoClassTests {
    DemoClass obj=new DemoClass();   
    @Test
    public void testSum() {  
    assertEquals(25,obj.sum(10, 15));  
         }  
}

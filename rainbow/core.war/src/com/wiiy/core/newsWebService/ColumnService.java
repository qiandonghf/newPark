
package com.wiiy.core.newsWebService;

import javax.jws.WebMethod;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.1.1 in JDK 6
 * Generated source version: 2.1
 * 
 */
@WebService(name = "columnService", targetNamespace = "http://service.webService.cloudService.wiiy.com/")
@SOAPBinding(style = SOAPBinding.Style.RPC)
public interface ColumnService {


    /**
     * 
     * @return
     *     returns java.lang.String
     */
    @WebMethod
    @WebResult(name = "sum", partName = "sum")
    public String columnStr();

}
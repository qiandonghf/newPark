
package com.wiiy.core.newsWebService;

import java.net.MalformedURLException;
import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.1.1 in JDK 6
 * Generated source version: 2.1
 * 
 */
@WebServiceClient(name = "CoulmnServiceImplService", targetNamespace = "http://impl.service.webService.cloudService.wiiy.com/", wsdlLocation = "http://211.152.54.193:96/cloudService/columnService?wsdl")
public class CoulmnServiceImplService
    extends Service
{

    private final static URL COULMNSERVICEIMPLSERVICE_WSDL_LOCATION;

    static {
        URL url = null;
        try {
            url = new URL("http://211.152.54.193:96/cloudService/columnService?wsdl");
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        COULMNSERVICEIMPLSERVICE_WSDL_LOCATION = url;
    }

    public CoulmnServiceImplService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public CoulmnServiceImplService() {
        super(COULMNSERVICEIMPLSERVICE_WSDL_LOCATION, new QName("http://impl.service.webService.cloudService.wiiy.com/", "CoulmnServiceImplService"));
    }

    /**
     * 
     * @return
     *     returns ColumnService
     */
    @WebEndpoint(name = "CoulmnServiceImplPort")
    public ColumnService getCoulmnServiceImplPort() {
        return (ColumnService)super.getPort(new QName("http://impl.service.webService.cloudService.wiiy.com/", "CoulmnServiceImplPort"), ColumnService.class);
    }

    /**
     * 
     * @param features
     *     A list of {@link javax.xml.ws.WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns ColumnService
     */
    @WebEndpoint(name = "CoulmnServiceImplPort")
    public ColumnService getCoulmnServiceImplPort(WebServiceFeature... features) {
        return (ColumnService)super.getPort(new QName("http://impl.service.webService.cloudService.wiiy.com/", "CoulmnServiceImplPort"), ColumnService.class, features);
    }

}

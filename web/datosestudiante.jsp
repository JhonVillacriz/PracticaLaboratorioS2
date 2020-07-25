<%@page import="java.sql.*" %>
<%@page import="bd.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
        <title>Datos Estudiante</title>
         <h1><i>Datos Estudiante</i></h1> 
        <%!
        //Variables globales
        String consulta;
        Connection cn;
        PreparedStatement pst;
        ResultSet rs ;
        String s_accion ;
        String s_idestudiante; 
        String s_nombre;
        String s_apellidos;
        String s_dni;
        String s_codigo;
        String s_estado;

        %>
    </head>
    <body>
         <% 
        //ecepcion
        try {
        ConectaBd bd = new ConectaBd() ; 
        cn= bd.getConnection();
        s_accion = request.getParameter("f_accion");
        s_idestudiante = request.getParameter("f_idestudiante");
       // primera parte del modificar
        if (s_accion!=null && s_accion.equals("M1")){
        consulta = " select nombre, apellidos, dni, codigo, estado "
                 + " from estudiante "
                 + " where "
                 + " idestudiante = " + s_idestudiante ;
       // out.print(consulta);
        pst = cn.prepareStatement(consulta);
        rs = pst.executeQuery();
        if (rs.next()){
                        %>
         <form name="EditarEstudianteForm" action="datosestudiante.jsp" method="GET">
            <table border="0"  align="center" class="azulino" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Editar Estudiante</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombre" value="<% out.print(rs.getString(1)); %>" maxlength="30" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Apellidos:</td>
                        <td><input type="text" name="f_apellidos" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>DNI:</td>
                        <td><input type="text" name="f_dni" value="<% out.print(rs.getString(3)); %>" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>Código:</td>
                        <td><input type="text" name="f_codigo" value="<% out.print(rs.getString(4)); %>" maxlength="12" size="15"/></td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td><input type="text" name="f_estado" value="<% out.print(rs.getString(5)); %>" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idestudiante" value="<%out.print(s_idestudiante);%>" />
                        </td>
                    </tr>                
                </tbody>
            </table>
        </form> 
        <br>
        <br>
        <%
            }
             }else{
                // Si no se hace la primera parte del modidicar debe mostrar el 
                // formulario de agregar estudiante
        %>
        
        <form name="AgregarEstudianteForm" action="datosestudiante.jsp" method="GET">
            <table border="0"   align="center" class="azulino" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2" >Agregar Estudiante</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombres:</td>
                        <td><input type="text" name="f_nombre" value="" maxlength="30" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Apellidos:</td>
                        <td><input type="text" name="f_apellidos" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>DNI:</td>
                        <td><input type="text" name="f_dni" value="" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>Código:</td>
                        <td><input type="text" name="f_codigo" value="" maxlength="12" size="15"/></td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td><input type="text" name="f_estado" value="" size="2"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                        </td>
                    </tr>                
                </tbody>
            </table>
        </form> 
     <%
            }
        %>    
       
       
        <table border="2"   align="center" class="azulino" style="margin: auto; display: table">
            <thead>
                <tr>
                    <th colspan="8">Datos Estudiante</th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>DNI</th>
                    <th>Código</th>
                    <th>Estado</th>
                    <th colspan="2">Acciones</th>
                   
                </tr>
            </thead>
 
        
        <%
        
        
        //s_idestudiante = request.getParameter("f_idestudiante");
                
                if (s_accion !=null) {
               
                // Ejecutar la eliminación de estudiantes
                
                    if (s_accion.equals("E")) {
                            consulta =    " delete from estudiante "
                                        + " where  "
                                        + " idestudiante = " + s_idestudiante +"; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                     // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_apellidos = request.getParameter("f_apellidos");
                        s_dni = request.getParameter("f_dni");
                        s_codigo = request.getParameter("f_codigo");
                        s_estado = request.getParameter("f_estado");
                        
                        consulta = " insert into "
                                + " estudiante (nombre, apellidos, dni, codigo, estado ) "
                                + " values( '"+ s_nombre +"' , '"+ s_apellidos +"' , '"+ s_dni +"' , '"+ s_codigo +"','"+s_estado+"'); " ;
                         //out.print (consulta);
                         pst = cn.prepareStatement(consulta);
                         pst.executeUpdate() ;
                          // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                        s_nombre = request.getParameter("f_nombre");
                        s_apellidos = request.getParameter("f_apellidos") ;
                        s_dni = request.getParameter("f_dni");
                        s_codigo = request.getParameter("f_codigo");
                        s_estado = request.getParameter("f_estado");
                        consulta = " update estudiante "
                                 + " set "
                                 + " nombre = '" + s_nombre + "'  , "
                                 + " apellidos = '" + s_apellidos + "'  , "
                                 + " dni = '" + s_dni + "', "       
                                 + " codigo = '" + s_codigo + "' , "
                                 + " estado = '" + s_estado + "' "
                                 + " where "
                                + " idestudiante = " + s_idestudiante + "; " ;
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate() ; 
                                 
                    }
                                  
                }
        
        consulta= " Select idestudiante , nombre ,apellidos,dni,codigo,estado "
                + " from estudiante " ;
          //consulta= " Select idestudiante, nombre, apellidos, dni, codigo, estado "
            //            + " from estudiante ";

      // out.println(consulta);
        pst = cn.prepareStatement(consulta);
        //rs es una lista (arreglo)
        rs = pst.executeQuery() ;
        String ide ;
        int num = 0 ;
        
        while (rs.next()) {  
            
        ide = rs.getString(1);
        num ++; 
            %>
            <tbody>
                <tr>
                   <td><% out.print(rs.getString(1)); %></td>
                   <td><% out.print(rs.getString(2)); %></td>
                   <td><% out.print(rs.getString(3)); %></td>
                   <td><% out.print(rs.getString(4)); %></td>
                   <td><% out.print(rs.getString(5)); %></td>
                   <td><% out.print(rs.getString(6)); %></td>
                   <td><a href="datosestudiante.jsp?f_accion=E&f_idestudiante=<%out.print(ide);%>"><img src="img/eliminar_25x25.png"  /></a></td>                 
                   <td><a href="datosestudiante.jsp?f_accion=M1&f_idestudiante=<%out.print(ide);%>"><img src="img/editar_25x25.png"  /></a></td>         
                   
                </tr>
      
            
            <%
            // Se cierra todas las conexiones         
            }
             rs.close();
             pst.close ();
             cn.close();

        }catch (Exception e){
            out.print("Error SQL");
            
            
        }
        %>
        </tbody>
      </table>
    </body>
</html>

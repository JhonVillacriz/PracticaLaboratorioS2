<%@page import="java.sql.*" %>
<%@page import="bd.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/Estilosparatabla.css" rel="stylesheet" type="text/css"/>
       
        <title>Datos Matricula</title>
         <h1><i>Datos Matricula</i></h1> 
        <%!
        //Variables globales
        String consulta;
        Connection cn;
        PreparedStatement pst;
        ResultSet rs ;
        String s_accion ;
        String s_idmatricula; 
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
        s_idmatricula = request.getParameter("f_idmatricula");
       // primera parte del modificar
        if (s_accion!=null && s_accion.equals("M1")){
        consulta = " select idmatricula, periodo, idestudiante, idcurso, idcarrera "
                 + " from matricula "
                 + " where "
                 + " idmatricula = " + s_idmatricula;
       // out.print(consulta);
        pst = cn.prepareStatement(consulta);
        rs = pst.executeQuery();
        if (rs.next()){
                        %>
         <form name="EditarMatriculaForm" action="DatosMatricula.jsp" method="GET">
            <table border="0"  align="center" class="azulino" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2">Editar Matrícula</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ID de Estudiante:</td>
                        <td><input type="text" name="f_idestudiante" value="<% out.print(rs.getString(3)); %>" maxlength="30" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Periodo:</td>
                        <td><input type="text" name="f_periodo" value="<% out.print(rs.getString(2)); %>" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>ID Curso:</td>
                        <td><input type="text" name="f_idcurso" value="<% out.print(rs.getString(4)); %>" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>ID Carrera:</td>
                        <td><input type="text" name="f_idcarrera" value="<% out.print(rs.getString(5)); %>" maxlength="12" size="15"/></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input type="submit" value="Editar" name="f_editar" />
                            <input type="hidden" name="f_accion" value="M2" />
                            <input type="hidden" name="f_idestudiante" value="<%out.print(s_idmatricula);%>" />
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
        
        <form name="AgregarEstudianteForm" action="DatosMatricula.jsp" method="GET">
            <table border="0"   align="center" class="azulino" style="margin: auto; display: table">
                <thead>
                    <tr>
                        <th colspan="2" >Agregar Matrícula</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>ID de Estudiante:</td>
                        <td><input type="text" name="f_idestudiante" value="" maxlength="30" size="25"/></td>
                    </tr>
                    <tr>
                        <td>Periodo:</td>
                        <td><input type="text" name="f_periodo" value="" maxlength="40" size="25"/></td>
                    </tr>
                    <tr>
                        <td>ID Curso:</td>
                        <td><input type="text" name="f_idcurso" value="" maxlength="8" size="8"/></td>
                    </tr>
                    <tr>
                        <td>ID Carrera:</td>
                        <td><input type="text" name="f_idcarrera" value="" maxlength="12" size="15"/></td>
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
        <br>
        <br>
        
        <table border="2"   align="center" class="azulino" style="margin: auto; display: table">
            <thead>
                <tr>
                    <th colspan="8">Datos Matrícula</th>
                </tr>
                <tr>
                    <th>ID Matrícula</th>
                    <th>Periodo</th>
                    <th>ID Estudiante</th>
                    <th>ID Curso</th>
                    <th>ID Carrera</th>
                    <th colspan="2">Acciones</th>
                   
                </tr>
            </thead>
 
        
        <%
        
        
        //s_idestudiante = request.getParameter("f_idestudiante");
                
                if (s_accion !=null) {
               
                // Ejecutar la eliminación de estudiantes
                
                    if (s_accion.equals("E")) {
                            consulta =    " delete from matricula "
                                        + " where  "
                                        + " idmatricula = " + s_idmatricula +"; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                     // Sino se elimina registros de estudiantes, 
                    // Pregunta si se va a REGISTRAR UN NUEVO ESTUDIANTE
                    }else if(s_accion.equals("C")) {
                        s_nombre = request.getParameter("f_periodo");
                        s_apellidos = request.getParameter("f_idestudiante");
                        s_dni = request.getParameter("f_idcurso");
                        s_codigo = request.getParameter("f_idcarrera");
                        
                        
                        consulta = " insert into "
                                + " matricula ( periodo, idestudiante, idcurso, idcarrera ) "
                                + " values( '"+ s_nombre +"' , '"+ s_apellidos +"' , '"+ s_dni +"' , '"+ s_codigo +"'); " ;
                         //out.print (consulta);
                         pst = cn.prepareStatement(consulta);
                         pst.executeUpdate() ;
                          // Si no se está creando o eliminando registro de estudiante
                    // Pregunta si va a hacer la MODIFICACIÓN DE ESTUDIANTES - Parte 2
                    }else if (s_accion.equals("M2")) {
                        s_nombre = request.getParameter("f_periodo");
                        s_apellidos = request.getParameter("f_idestudiante") ;
                        s_dni = request.getParameter("f_idcurso");
                        s_codigo = request.getParameter("f_idcarrera");
                        
                        consulta = " update matricula "
                                 + " set "
                                 + " periodo = '" + s_nombre + "'  , "
                                 + " idestudiante = '" + s_apellidos + "'  , "
                                 + " idcurso = '" + s_dni + "', "       
                                 + " idcarrera = '" + s_codigo + "'  "                                
                                 + " where "
                                + " idmatricula = " + s_idmatricula + "; " ;
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate() ; 
                                 
                    }
                                  
                }
        
        consulta= " Select idmatricula , periodo ,idestudiante,idcurso,idcarrera "
                + " from matricula " ;
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
                   
                   <td><a href="DatosMatricula.jsp?f_accion=E&f_idmatricula=<%out.print(ide);%>"><img src="img/eliminar_25x25.png"  /></a></td>                 
                   <td><a href="DatosMatricula.jsp?f_accion=M1&f_idmatricula=<%out.print(ide);%>"><img src="img/editar_25x25.png"  /></a></td>         
                   
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
        <tr align="center">
                <td colspan="8"><a href="menu.jsp"> <input type="submit" value="Menú" /> </a>
                       </td>
                </tr>
            
            </tbody>
      
        </table>
    </body>
    
    
    
</html>

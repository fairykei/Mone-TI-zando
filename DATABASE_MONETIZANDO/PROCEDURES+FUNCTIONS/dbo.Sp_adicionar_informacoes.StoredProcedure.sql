USE [MEU]
GO
/****** Object:  StoredProcedure [dbo].[Sp_adicionar_informacoes]    Script Date: 22/12/2018 12:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[Sp_adicionar_informacoes] @TEMPO_ATIVIDADE     VARCHAR(100),   
                                          @PORCENTAGEM_USO     VARCHAR(30),   
                                          @IPV4                VARCHAR(50),   
                                          @IPV6                VARCHAR(50),   
                                          @MAC_ADDRESS         VARCHAR(50),   
                                          @VELOCIDADE_DOWNLOAD VARCHAR(50),   
                                          @VELOCIDADE_UPLOAD   VARCHAR(50),   
                                          @TOTAL               REAL,   
                                          @LIVRE               REAL,   
                                          @EM_USO              REAL,
										  @PORCENTAGEM_USO_RAM     INT
AS   
    DECLARE @ID_COMPUTADOR INT   
  
  BEGIN   
      IF EXISTS (SELECT PC.id_computador   
                 FROM   peek_computador PC   
                        INNER JOIN peek_mac_address PMA   
                                ON PC.id_computador = PMA.id_computador   
                 WHERE  PMA.mac_address = @MAC_ADDRESS)   
        BEGIN   
            SET @ID_COMPUTADOR = (SELECT PC.id_computador   
                                  FROM   peek_computador PC   
                                         INNER JOIN peek_mac_address PMA   
                                                 ON PC.id_computador =   
                                                    PMA.id_computador   
                                  WHERE  PMA.mac_address = @MAC_ADDRESS)   
  
            INSERT INTO peek_processador   
                        (tempo_atividade,   
                         porcentagem_uso,   
                         id_computador)   
            VALUES     (@TEMPO_ATIVIDADE,   
                        @PORCENTAGEM_USO,   
                        @ID_COMPUTADOR)   
  
         
        
            INSERT INTO peek_rede   
                        (ipv4,   
                         ipv6,   
                         mac_address,   
                         velocidade_download,   
                         velocidade_upload,   
                         id_computador)   
            VALUES      (@IPV4,   
                         @IPV6,   
                         @MAC_ADDRESS,   
                         @VELOCIDADE_DOWNLOAD,   
                         @VELOCIDADE_UPLOAD,   
                         @ID_COMPUTADOR)   
  
            INSERT INTO peek_memoria_ram   
                        (total,   
                         livre,   
                         em_uso,  
						 porcentagem_uso, 
                         id_computador)   
            VALUES      (@TOTAL,   
                         @LIVRE,   
                         @EM_USO,
						 @PORCENTAGEM_USO_RAM,   
                         @ID_COMPUTADOR)   
        END;  
  END;
GO

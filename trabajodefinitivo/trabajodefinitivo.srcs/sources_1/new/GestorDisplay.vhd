library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity GestorDisplay is
    generic(
        width: positive:=3
        );
    port(
        CLK : in std_logic;
        code1 : in std_logic_vector(width downto 0);
        code2 : in std_logic_vector(width downto 0);
        code3 : in std_logic_vector(width downto 0);
        code4 : in std_logic_vector(width downto 0);
        code5 : in std_logic_vector(width downto 0);
        code6 : in std_logic_vector(width downto 0);
        code7 : in std_logic_vector(width downto 0);
        code8 : in std_logic_vector(width downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0); --vector que pone a 1 el �nodo correspondiente para actualizar
        salida_disp : out std_logic_vector(6 downto 0) --salida de los displays
    );
end GestorDisplay;

architecture Behavioral of GestorDisplay is
    
    signal disp1 : std_logic_vector(6 downto 0);
    signal disp2 : std_logic_vector(6 downto 0);
    signal disp3 : std_logic_vector(6 downto 0);
    signal disp4 : std_logic_vector(6 downto 0);
    signal disp5 : std_logic_vector(6 downto 0);
    signal disp6 : std_logic_vector(6 downto 0);
    signal disp7 : std_logic_vector(6 downto 0);
    signal disp8 : std_logic_vector(6 downto 0);
    
    signal count : integer := 1; -- n�mero del display a usar
    
    signal clk_10khz : std_logic;
    
    COMPONENT clk10khz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
     END COMPONENT;
    
    COMPONENT decoder
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
begin

Inst_clk10khz: clk10khz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_10khz
    );

Inst_deco1: decoder PORT MAP (
        code => code1,
        led => disp1
);
Inst_deco2: decoder PORT MAP (
        code => code2,
        led => disp2
);
Inst_deco3: decoder PORT MAP (
        code => code3,
        led => disp3
);
Inst_deco4: decoder PORT MAP (
        code => code4,
        led => disp4
);
Inst_deco5: decoder PORT MAP (
        code => code5,
        led => disp5
);
Inst_deco6: decoder PORT MAP (
        code => code6,
        led => disp6
);
Inst_deco7: decoder PORT MAP (
        code => code7,
        led => disp7
);
Inst_deco8: decoder PORT MAP (
        code => code8,
        led => disp8
);


    process (clk_10khz)
    begin
        if rising_edge(clk_10khz) then
            if count=1 then
                refrescar_anodo(0)<='0';
                refrescar_anodo(7 downto 1)<="1111111";
                salida_disp<=disp1;
                count<=2;
            end if;
            if count=2 then
                refrescar_anodo(1)<='0';
                refrescar_anodo(0)<='1';
                refrescar_anodo(7 downto 2)<="111111";
                salida_disp <= disp2;
                count<=3;
            end if;
            if count=3 then
                refrescar_anodo(2)<='0';
                refrescar_anodo(1 downto 0)<="11";
                refrescar_anodo(7 downto 3)<="11111";
                salida_disp<=disp3;
                count<=4;
            end if;
            if count=4 then
                refrescar_anodo(3)<='0';
                refrescar_anodo(2 downto 0)<="111";
                refrescar_anodo(7 downto 4)<="1111";
                salida_disp <= disp4;
                count<=5;
            end if;
            if count=5 then
                refrescar_anodo(4)<='0';
                refrescar_anodo(3 downto 0)<="1111";
                refrescar_anodo(7 downto 5)<="111";
                salida_disp<=disp5;
                count<=6;
            end if;
            if count=6 then
                refrescar_anodo(5)<='0';
                refrescar_anodo(4 downto 0)<="11111";
                refrescar_anodo(7 downto 6)<="11";
                salida_disp <= disp6;
                count<=7;
            end if;
            if count=7 then
                refrescar_anodo(6)<='0';
                refrescar_anodo(5 downto 0)<="111111";
                refrescar_anodo(7)<='1';
                salida_disp<=disp7;
                count<=8;
            end if;
            if count=8 then
                refrescar_anodo(7)<='0';
                refrescar_anodo(6 downto 0)<="1111111";
                salida_disp<=disp8;
                count<=1;
            end if;
        end if;

    end process;

end Behavioral;
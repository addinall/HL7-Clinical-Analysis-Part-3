delimiter //
-- vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
-- With thanks to Peter Brawley for the assist
-- My implementation had temp tables and loops!
--
-- Best.SQL
-- Reads a table constructed froma CSV HL7 file
-- and finds the hospital with the BEST OUTCOMES
-- by state - ilness
--
-- Mark Addinall - 2014
--
-- call Best("VIC", "Death_Rated_Heart_Failure", @result);

drop procedure if exists `Best`//

create procedure Best( 	IN  p_state 	VARCHAR(255), 
			            IN  p_illness 	VARCHAR(255),
			            OUT p_name 	    VARCHAR(255))
begin

    set @local_name = NULL;   -- firstly we need this as it seems mySQL
                              -- can only use @variables in a statement to
                              -- be prepared for execution.  Trying to use
                              -- the INOUT or OUT p_name just gives an
                              -- undefined variable error.
                              -- We NEED to set this to NULL on entry as
                              -- it is persistant over the life of the 
                              -- SESSION.  If the query fails, it retains the
                              -- value of the last successful execution!
                              -- EEEK!

    set @p_query = concat("select Hospital_Name into @local_name",  
    	" from hospital_outcomes where ", p_illness, " > 0 and State = '", p_state, 
    		"' order by ", p_illness, ", Hospital_Name ",   
    		"Limit 1;");

	prepare best_query
	    from @p_query;
	
    execute best_query;

    if isnull(@local_name) then
        set p_name = 'NA';
    else
        set p_name = @local_name;
    end if;

end //

delimiter ;



CREATE OR REPLACE trigger wwv_bu_flow_themes
    before update on wwv_flow_themes
    for each row
begin
   for c1 in (select theme_id from wwv_flows where id = :new.flow_id
                       and security_group_id = :new.security_group_id) loop
        if :new.theme_id = c1.theme_id  then
            update wwv_flows set
                   default_button_template  = :new.default_button_template,
                   default_calendar_template  = :new.default_calendar_template ,
                   default_chart_template  = :new.default_chart_template ,
                   default_form_template  = :new.default_form_template ,
                   default_label_template  = :new.default_label_template ,
                   default_list_template  = :new.default_list_template ,
                   default_listr_template  = :new.default_listr_template ,
                   default_menu_template  = :new.default_menu_template ,
                   default_menur_template  = :new.default_menur_template ,
                   default_page_template  = :new.default_page_template ,
                   default_region_template  = :new.default_region_template ,
                   default_report_template  = :new.default_report_template ,
                   default_reportr_template  = :new.default_reportr_template ,
                   default_tabform_template  = :new.default_tabform_template ,
                   default_wizard_template  = :new.default_wizard_template ,
                   error_template  = :new.error_template ,
                   printer_friendly_template  = :new.printer_friendly_template
            where id = :new.flow_id
              and security_group_id = :new.security_group_id;
        end if;
    end loop;
end;
/
CREATE OR REPLACE package wwv_flow_generic_attr
is

g_attribute_value wwv_flow_global.vc_arr2;

function fetch_attribute (
    p_region_id     in number,
    p_attribute_id  in number)
    return varchar2
    ;

procedure fetch_attributes (
    --
    -- populates wwv_flow_generic.g_attribute_value array
    --
    p_region_id     in number,
    p_value_count   in number default 100)
    ;

procedure set_attribute (
    p_region_id     in number,
    p_attribute_id  in number,
    p_value         in varchar2 default null)
    ;

procedure set_attributes (
    p_region_id     in number,
    p_value_01      in varchar2 default null,
    p_value_02      in varchar2 default null,
    p_value_03      in varchar2 default null,
    p_value_04      in varchar2 default null,
    p_value_05      in varchar2 default null,
    p_value_06      in varchar2 default null,
    p_value_07      in varchar2 default null,
    p_value_08      in varchar2 default null,
    p_value_09      in varchar2 default null,
    p_value_10      in varchar2 default null,
    p_value_11      in varchar2 default null,
    p_value_12      in varchar2 default null,
    p_value_13      in varchar2 default null,
    p_value_14      in varchar2 default null,
    p_value_15      in varchar2 default null,
    p_value_16      in varchar2 default null,
    p_value_17      in varchar2 default null,
    p_value_18      in varchar2 default null,
    p_value_19      in varchar2 default null,
    p_value_20      in varchar2 default null,
    p_value_21      in varchar2 default null,
    p_value_22      in varchar2 default null,
    p_value_23      in varchar2 default null,
    p_value_24      in varchar2 default null,
    p_value_25      in varchar2 default null,
    p_value_26      in varchar2 default null,
    p_value_27      in varchar2 default null,
    p_value_28      in varchar2 default null,
    p_value_29      in varchar2 default null,
    p_value_30      in varchar2 default null,
    p_value_31      in varchar2 default null,
    p_value_32      in varchar2 default null,
    p_value_33      in varchar2 default null,
    p_value_34      in varchar2 default null,
    p_value_35      in varchar2 default null,
    p_value_36      in varchar2 default null,
    p_value_37      in varchar2 default null,
    p_value_38      in varchar2 default null,
    p_value_39      in varchar2 default null,
    p_value_40      in varchar2 default null,
    p_value_41      in varchar2 default null,
    p_value_42      in varchar2 default null,
    p_value_43      in varchar2 default null,
    p_value_44      in varchar2 default null,
    p_value_45      in varchar2 default null,
    p_value_46      in varchar2 default null,
    p_value_47      in varchar2 default null,
    p_value_48      in varchar2 default null,
    p_value_49      in varchar2 default null,
    p_value_50      in varchar2 default null,
    p_value_51      in varchar2 default null,
    p_value_52      in varchar2 default null,
    p_value_53      in varchar2 default null,
    p_value_54      in varchar2 default null,
    p_value_55      in varchar2 default null,
    p_value_56      in varchar2 default null,
    p_value_57      in varchar2 default null,
    p_value_58      in varchar2 default null,
    p_value_59      in varchar2 default null,
    p_value_60      in varchar2 default null,
    p_value_61      in varchar2 default null,
    p_value_62      in varchar2 default null,
    p_value_63      in varchar2 default null,
    p_value_64      in varchar2 default null,
    p_value_65      in varchar2 default null,
    p_value_66      in varchar2 default null,
    p_value_67      in varchar2 default null,
    p_value_68      in varchar2 default null,
    p_value_69      in varchar2 default null,
    p_value_70      in varchar2 default null,
    p_value_71      in varchar2 default null,
    p_value_72      in varchar2 default null,
    p_value_73      in varchar2 default null,
    p_value_74      in varchar2 default null,
    p_value_75      in varchar2 default null,
    p_value_76      in varchar2 default null,
    p_value_77      in varchar2 default null,
    p_value_78      in varchar2 default null,
    p_value_79      in varchar2 default null,
    p_value_80      in varchar2 default null,
    p_value_81      in varchar2 default null,
    p_value_82      in varchar2 default null,
    p_value_83      in varchar2 default null,
    p_value_84      in varchar2 default null,
    p_value_85      in varchar2 default null,
    p_value_86      in varchar2 default null,
    p_value_87      in varchar2 default null,
    p_value_88      in varchar2 default null,
    p_value_89      in varchar2 default null,
    p_value_90      in varchar2 default null,
    p_value_91      in varchar2 default null,
    p_value_92      in varchar2 default null,
    p_value_93      in varchar2 default null,
    p_value_94      in varchar2 default null,
    p_value_95      in varchar2 default null,
    p_value_96      in varchar2 default null,
    p_value_97      in varchar2 default null,
    p_value_98      in varchar2 default null,
    p_value_99      in varchar2 default null,
    p_value_100     in varchar2 default null,
    p_value_count   in number   default 100)
    ;

end wwv_flow_generic_attr;
/
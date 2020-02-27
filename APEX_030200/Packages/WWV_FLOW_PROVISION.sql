CREATE OR REPLACE package wwv_flow_provision
as

/* ------------- PROVISIONING API -------------------- */

/*
 * creates a user account, creates a tablespace for the user, and
 * grants the user privileges to create objects and such.
 *
 * p_quota:  the size in MBytes the company is allocated
 *
 * rules for p_company:
 * - Must be from 1 to 30 bytes long
 * - Cannot contain quotation marks
 * - Must begin with an alphabetic character from THIS database set
 * - Can only contain alphanumeric characters, with the exception of
 *   (_) underscore, ($) dollar, and (#) pound signs.
 * - Cannot be an oracle reserved word
 * - Cannot be DUAL
 */
procedure provision_company(
    p_company         in varchar2,
    p_password        in varchar2,
    p_quota           in number                  default 20)
    ;


/*
 * removes the company's tablespace(s) (including contents cascade
 * constraints); drops the company's flows schema user
 */
procedure remove_provisioned_company(
    p_company         in varchar2)
    ;


/*
 * this adds more space to the company's storage capacity.  We will
 * extend the tablespace to allow for more data.
 *
 * p_add: the size (in MB) you are extending the tablespace
 */
procedure change_provisioned_storage(
    p_sgid            in number,
    p_newsize         in number)
    ;


/*
 * returns the number of bytes which have been provisioned to this company
 */
function get_provisioned_space(
    p_sgid            in number)
    return number
    ;

/*
 * returns the number of bytes being used by this company
 */
function get_space_consumption(
    p_sgid            in number)
    return number
    ;


/*
 * function which returns a password of varying length
 *
 *   p_length indicates the length of the password you wish to be
 *    randomly generated
 */
function get_random_password(
    p_length          in number)
    return varchar2
    ;

/*
 * When provisioning companies, use this function to verify the
 * words you are passing are NOT reserved.
 *
 */
function is_reserved(
    p_word            in varchar2)
    return boolean
    ;

/*
 *
 */
procedure create_user(
    p_username        in varchar2,
    p_password        in varchar2)
    ;

/*
 *
 */
procedure drop_user(
    p_username        in varchar2,
    p_cascade         in boolean default TRUE,
    p_drop_ts         in boolean default FALSE)
    ;

/*
 *
 */
procedure set_user_tablespace(
    p_username        in varchar2,
    p_default_ts      in varchar2         default 'USERS',
    p_temp_ts         in varchar2         default 'TEMP')
    ;


/*
 *
 */
procedure grant_initial_privs(
    p_username        in varchar2)
    ;

procedure setup_company_tablespace(
    p_company in varchar2,
    p_size    in number)
    ;

end wwv_flow_provision;
/
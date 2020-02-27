CREATE OR REPLACE package wwv_flow_plsql_job
as

g_job number;

/*
 * This function updates the wwv_flow_jobs table with values passed
 * in.  This can be called from the process itself, which in turn
 * allows the application to see all it's own outstanding jobs
 * running and their status or error text.
 * Arguments:
 *  p_job: passed the reserved word JOB.  when this code is executed
 *         it will have visibility to the job number via the reserved
 *         word JOB.
 *  p_status: plain text that you want associated with JOB: p_job
 *  p_desc: in case you need additional text for explaining the status
 *          field, you can pass it here.
 * Note:
 *  wwv_flow_security.g_security_group_id must be the sgid of the JOB
 *  originator
 */
procedure update_job_status(
    p_job                 in number,
    p_status              in varchar2)
    ;

/*
 *  Deprecated - Please apply any changes to the overloaded version with p_when as a date type
 */
function submit_process(
    p_sql                 in varchar2,
    p_when                in varchar2    default sysdate,
    p_status              in varchar2    default 'PENDING')
    return number
    ;

/*
 * Submit a process to be placed in the "background" of your session.
 * Arguments:
 *  p_sql: the process you wish to run in your job
 *  p_when: when you want to run it.  default is "ASAP" (type date)
 *  p_totalwork: the total number of units of work to be accomplished.
 *               this is useful when you are checking status
 *  p_status: plain text status information for this job.  this will
 *            eventually be updateable through this API.
 *  p_units: plain text value of what "units" p_totalwork refers to
 */
function submit_process(
    p_sql                 in varchar2,
    p_when                in date        default sysdate,
    p_status              in varchar2    default 'PENDING')
    return number
    ;

/*
 * processes may only be removed if they have not begun.  this call
 * can be made without problems regardless of whether the job has begun
 * or not.
 * Note:
 *  wwv_flow_security.g_security_group_id must be the sgid of the JOB
 *  originator
 */
procedure purge_process(
    p_job                 in number)
    ;

/*
 * This function is for determining whether or not the database
 * instance is configured to run jobs or not.
 */
function jobs_are_enabled
    return boolean
    ;

/*
 * determine the amount of time which has elapsed since the job
 * was submitted.
 * (ie, l_elapsed_minutes := wwv_flow_job.time_elapsed(l_myjobno)/1440;
 */
function time_elapsed(
    p_job                 in number)
    return number
    ;

end wwv_flow_plsql_job;
/
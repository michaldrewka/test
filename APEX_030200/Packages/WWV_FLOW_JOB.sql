CREATE OR REPLACE package wwv_flow_job
as

/*
 * For internal use.  DO NOT call this package as it's only
 * meaningful to the body of this application.
 */
procedure run_internal_job(
    p_job                 in number,
    p_language            in varchar2 default null)
    ;


/*
 * Used to update the SYSTEM_STATUS of a wwv_flow_job.
 */
procedure update_system_status(
    p_job                 in number,
    p_system_status       in varchar2)
    ;


/*
 * For removing jobs.  We need to ensure that sloppy flows
 * developers do not cause an extraneous amount of completed
 * jobs which have not been cleaned out.
 */
procedure remove_job(
    p_job                 in number)
    ;


/*
 * For internal use.  We need to ensure that sloppy flows
 * developers do not cause an extraneous amount of completed
 * jobs which have not been cleaned out.
 */
procedure cleanup_completed_jobs(
    p_completed_before        in date)
    ;

end wwv_flow_job;
/
local Job = Prototype:clone("Job")
Job.isJob = true

function Job:init() return self end

function Job:update(dt) end

return Job

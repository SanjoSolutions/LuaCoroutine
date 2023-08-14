local addOnName = 'Coroutine'
local version = '2.0.0'

if _G.Library then
  if not Library.isRegistered(addOnName, version) then
    --- @class Coroutine
    local Coroutine = {}

    function Coroutine.runAsCoroutine(fn)
      local thread = coroutine.create(fn)
      RunNextFrame(function()
        Coroutine.resumeWithShowingError(thread)
      end)
      return thread
    end

    --- @deprecated Please use Coroutine.runAsCoroutine instead.
    Coroutine.runNextFrame = Coroutine.runAsCoroutine

    function Coroutine.runAsCoroutineImmediately(fn)
      local thread = coroutine.create(fn)
      Coroutine.resumeWithShowingError(thread)
      return thread
    end

    function Coroutine.resumeWithShowingError(thread, ...)
      local result = { coroutine.resume(thread, ...) }
      local wasSuccessful = result[1]
      if not wasSuccessful then
        local errorMessage = result[2]
        error(errorMessage .. '\n' .. debugstack(thread), 0)
      end
      return unpack(result)
    end

    function Coroutine.waitFor(predicate, timeout)
      if predicate() then
        return true
      else
        local thread = coroutine.running()
        local ticker
        local startTime = GetTime()
        ticker = C_Timer.NewTicker(0, function()
          if predicate() then
            ticker:Cancel()
            Coroutine.resumeWithShowingError(thread, true)
          elseif timeout and GetTime() - startTime >= timeout then
            ticker:Cancel()
            Coroutine.resumeWithShowingError(thread, false)
          end
        end)
        return coroutine.yield()
      end
    end

    Coroutine.waitUntil = Coroutine.waitFor

    function Coroutine.waitForDuration(duration)
      local thread = coroutine.running()
      C_Timer.After(duration, function()
        Coroutine.resumeWithShowingError(thread)
      end)
      return coroutine.yield()
    end

    function Coroutine.yieldAndResume()
      local thread = coroutine.running()
      C_Timer.After(0, function()
        Coroutine.resumeWithShowingError(thread)
      end)
      coroutine.yield()
    end

    Library.register(addOnName, version, Coroutine)
  end
else
  error(addOnName + ' requires Library. It seems absent.')
end

local NoName, bot = ...

bot.BehaviorTree = {}

function bot.BehaviorTree.selector(name, children)
    return { type = "selector", name = name, children = children }
end

function bot.BehaviorTree.sequence(name, children)
    return { type = "sequence", name = name, children = children }
end

function bot.BehaviorTree.action(name, func)
    return { type = "action", name = name, func = func }
end

function bot.BehaviorTree.condition(name, func)
    return { type = "condition", name = name, func = func }
end

function bot.BehaviorTree.execute(node)
    if node.type == "selector" then
        for _, child in ipairs(node.children) do
            local result = bot.BehaviorTree.execute(child)
            if result then
                return true
            end
        end
        return false
    elseif node.type == "sequence" then
        for _, child in ipairs(node.children) do
            local result = bot.BehaviorTree.execute(child)
            if not result then
                return false
            end
        end
        return true
    elseif node.type == "action" then
        return node.func()
    elseif node.type == "condition" then
        return node.func()
    else
        error("Invalid node type")
    end
end

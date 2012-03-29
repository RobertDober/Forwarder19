class Integer
  class << self
    def pred
      lambda{ |a| a.pred }
    end
    def succ
      lambda{ |a| a.succ }
    end
    def sum
      -> *args do
        args.reduce{ |a,b| a + b }
      end
    end
    def diff
      -> a, b do
        a - b
      end
    end
    def prod
      -> *args do
        args.reduce{ |a,b| a * b }
      end
    end
    def div
      -> a, b do
        a / b
      end
    end
    def mod
      -> a, b do
        a % b
      end
    end
  end # class << self
end # class Proc


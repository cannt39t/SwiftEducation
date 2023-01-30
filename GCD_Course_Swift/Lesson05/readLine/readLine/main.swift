//
//  main.swift
//  readLine
//
//  Created by Илья Казначеев on 28.12.2022.
//

import Foundation

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()


class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printMethod()
    }
    
    private func printMethod() {
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Printer exit")
    }
    
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writeMethod()
    }
    
    private func writeMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        pthread_cond_signal(&condition)
        available = true
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer exit")
    }
    
}


let conditionWriter = ConditionMutexWriter()
let conditionPrinter = ConditionMutexPrinter()
conditionPrinter.start()
conditionWriter.start()
